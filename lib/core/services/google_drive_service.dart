import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:http/http.dart' as http;
import 'package:my_password_app/core/models/password_model.dart';
import 'package:path_provider/path_provider.dart' as path;

final googleDriveService = Provider<GoogleDriveService>((ref) {
  return GoogleDriveService();
});

class GoogleDriveService {
  Future<void> syncPasswordList({
    required GoogleSignInAccount account,
    required List<PasswordModel> list,
  }) async {
    final driveApi = await _driveApi(account);

    final result = await driveApi.files.list(
      q: "name = '${_fileName(account)}'",
      $fields: "files(id, name)",
    );
    print("List result: ${result.files?.toString()}");
    final file = File(name: _fileName(account));

    if ((result.files?.isEmpty ?? true) || result.files!.first.id == null) {
      final jsonString = jsonEncode(list.map((e) => e.toJson()).toList());
      final media = _toMedia(jsonString);

      await driveApi.files.create(
        file,
        uploadMedia: media,
      );
    } else {
      final driveId = result.files!.first.id!;
      final lastData = await getLastData(driveId, account, driveApi);
      // TODO remove duplicate
      final jsonString = jsonEncode(list.map((e) => e.toJson()).toList());
      final media = _toMedia(jsonString);

      driveApi.files.update(
        file,
        driveId,
        uploadMedia: media,
      );
    }
  }

  Future<List<PasswordModel>> getLastData(
    String fileId,
    GoogleSignInAccount account,
    DriveApi driveApi,
  ) async {
    final result = await driveApi.files
        .get(fileId, downloadOptions: DownloadOptions.fullMedia);
    if (!(result is Media)) {
      throw "Not Receive Media Object";
    }

    final dataStore = await result.stream.toList();
    if (await dataStore.isEmpty) {
      return [];
    }

    final tempDir = await path
        .getTemporaryDirectory(); //Get temp folder using Path Provider
    final tempPath = tempDir.path; //Get path to that location
    final file = io.File('$tempPath/temporary_file'); //Create a dummy file
    await file.writeAsBytes(dataStore
        .first); //Write to that file from the datastore you created from the Media stream
    String jsonString = file.readAsStringSync(); // Read String from the file
    print("jsonString => $jsonString"); //Finally you have your text
    final jsonMap = json.decode(jsonString);
    print("jsonMap => $jsonMap");
    if (!(jsonMap is List)) {
      throw "Result Not List";
    }
    return jsonMap.map((e) => PasswordModel.fromJson(e)).toList();
  }

  String _fileName(
    GoogleSignInAccount account,
  ) {
    return "protect_${account.email}.json";
  }

  Media _toMedia(String jsonString) {
    final mediaStream =
        Future.value(jsonString.codeUnits).asStream().asBroadcastStream();
    final media = new Media(mediaStream, jsonString.length);
    return media;
  }

  Future<DriveApi> _driveApi(
    GoogleSignInAccount googleSignInAccount,
  ) async {
    final authHeaders = await googleSignInAccount.authHeaders;
    final authenticateClient = _GoogleAuthClient(authHeaders);
    return DriveApi(authenticateClient);
  }
}

class _GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;

  final http.Client _client = new http.Client();

  _GoogleAuthClient(this._headers);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}
