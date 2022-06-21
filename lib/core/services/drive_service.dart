import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:my_password_app/core/models/password_application_model.dart';

class _GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;

  final http.Client _client = new http.Client();

  _GoogleAuthClient(this._headers);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

class DriveService {
  static void createFilePassword({
    required GoogleSignInAccount googleSignInAccount,
    required PasswordApplicationModel password,
  }) async {
    final driveApi = await _driveApi(googleSignInAccount);

    final jsonString = json.encode(password.toJson());

    final driveFile = new drive.File();
    driveFile.name = _fileName(googleSignInAccount);

    final result = await driveApi.files
        .create(driveFile, uploadMedia: _toMedia(jsonString));
    print("Upload result: $result");
  }

  static void updateFilePassword({
    required GoogleSignInAccount googleSignInAccount,
    required PasswordApplicationModel password,
  }) async {
    final driveApi = await _driveApi(googleSignInAccount);

    final jsonString = json.encode(password.toJson());

    final driveFile = new drive.File();
    driveFile.name = _fileName(googleSignInAccount);

    final fileId = await getFile(googleSignInAccount: googleSignInAccount);

    final result = await driveApi.files
        .update(driveFile, fileId, uploadMedia: _toMedia(jsonString));
    print("Update result: $result");
  }

  static Future<String> getFile({
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
      throw "File Not Found";
    }

    if (result.files!.first.id == null) {
      throw "Id Not Found";
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
