import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:my_password_app/core/exceptions/file_not_found_exception.dart';
import 'package:my_password_app/core/exceptions/id_not_found_exception.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:path_provider/path_provider.dart';

class _GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;

  final http.Client _client = new http.Client();

  _GoogleAuthClient(this._headers);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

class DriveService {
  static Future<void> initFilePassword({
    required GoogleSignInAccount googleSignInAccount,
  }) async {
    final driveApi = await _driveApi(googleSignInAccount);

    final driveFile = new drive.File();
    driveFile.name = _fileName(googleSignInAccount);

    final result = await driveApi.files.create(driveFile);
    print("Upload result: $result");
  }

  static void updateFilePassword({
    required GoogleSignInAccount googleSignInAccount,
    required List<PasswordModel> password,
  }) async {
    late final String fileId;
    try {
      fileId = await getFileId(googleSignInAccount: googleSignInAccount);
    } on FileNotFoundException catch (_) {
      await initFilePassword(googleSignInAccount: googleSignInAccount);
    }

    final driveApi = await _driveApi(googleSignInAccount);
    final jsonString = json.encode(password
        .map(
          (e) => PasswordModel(
            name: e.name,
            password: e.password.encrypt,
          ),
        )
        .toList());

    final driveFile = new drive.File();
    driveFile.name = _fileName(googleSignInAccount);

    final result = await driveApi.files
        .update(driveFile, fileId, uploadMedia: _toMedia(jsonString));
    print("Update result: $result");
  }

  static Future<List<PasswordModel>> receiveFilePassword({
    required GoogleSignInAccount googleSignInAccount,
  }) async {
    final driveApi = await _driveApi(googleSignInAccount);
    final fileId = await getFileId(googleSignInAccount: googleSignInAccount);
    final result = await driveApi.files
        .get(fileId, downloadOptions: drive.DownloadOptions.fullMedia);
    if (!(result is drive.Media)) {
      throw "Not Receive Media Object";
    }

    List<PasswordModel> listPassword = [];
    final dataStore = await result.stream.first;

    Directory tempDir =
        await getTemporaryDirectory(); //Get temp folder using Path Provider
    String tempPath = tempDir.path; //Get path to that location
    File file = File('$tempPath/temporary_file'); //Create a dummy file
    await file.writeAsBytes(
        dataStore); //Write to that file from the datastore you created from the Media stream
    String jsonString = file.readAsStringSync(); // Read String from the file
    print("jsonString => $jsonString"); //Finally you have your text
    final jsonMap = json.decode(jsonString);
    print("jsonMap => $jsonMap");
    if (!(jsonMap is List)) {
      throw "Result Not List";
    }
    listPassword = jsonMap.map((e) => PasswordModel.fromJson(e)).toList();
    listPassword = listPassword
        .map((e) => PasswordModel(name: e.name, password: e.password.decrypt))
        .toList();
    return listPassword;
  }

  static Future<String> getFileId({
    required GoogleSignInAccount googleSignInAccount,
  }) async {
    final driveApi = await _driveApi(googleSignInAccount);

    final driveFile = new drive.File();
    driveFile.name = _fileName(googleSignInAccount);

    final result = await driveApi.files.list(
      q: "name = '${_fileName(googleSignInAccount)}'",
      $fields: "files(id, name)",
    );
    print("List result: ${result.files?.toString()}");

    if (result.files?.isEmpty ?? true) {
      throw FileNotFoundException("File Not Found");
    }

    if (result.files!.first.id == null) {
      throw IdNotFoundException("Id Not Found");
    }

    return result.files!.first.id!;
  }

  static Future<drive.DriveApi> _driveApi(
    GoogleSignInAccount googleSignInAccount,
  ) async {
    final authHeaders = await googleSignInAccount.authHeaders;
    final authenticateClient = _GoogleAuthClient(authHeaders);
    return drive.DriveApi(authenticateClient);
  }

  static drive.Media _toMedia(String jsonString) {
    final mediaStream =
        Future.value(jsonString.codeUnits).asStream().asBroadcastStream();
    final media = new drive.Media(mediaStream, jsonString.length);
    return media;
  }

  static String _fileName(
    GoogleSignInAccount googleSignInAccount,
  ) {
    return "protect_${googleSignInAccount.email}.txt";
  }
}
