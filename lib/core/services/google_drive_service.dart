import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:http/http.dart' as http;
import 'package:my_password_app/core/enums/sync_enum.dart';
import 'package:my_password_app/core/models/password_model.dart';
import 'package:my_password_app/core/services/encrypt_data_service.dart';
import 'package:my_password_app/core/utils/my_print.dart';

final googleDriveService = Provider<GoogleDriveService>((ref) {
  return GoogleDriveService(
    ref.watch(encryptDataService),
  );
});

class GoogleDriveService {
  GoogleDriveService(this._encryptDataService);

  final EncryptDataService _encryptDataService;

  Future<List<PasswordModel>> syncPasswordList({
    required GoogleSignInAccount account,
    required List<PasswordModel> list,
    required SyncEnum sync,
  }) async {
    final driveApi = await _driveApi(account);

    final result = await driveApi.files.list(
      q: "name = '${_fileName(account)}'",
      $fields: "files(id, name)",
    );
    print("List result: ${result.files?.toString()}");
    final file = File(name: _fileName(account));

    if ((result.files?.isEmpty ?? true) || result.files!.first.id == null) {
      myPrint('file on drive not found');
      final jsonString = jsonEncode(list.map((e) => e.toJson()).toList());
      final encoded = _encryptDataService.encode(jsonString);
      final media = _toMedia(encoded);

      await driveApi.files.create(
        file,
        uploadMedia: media,
      );
      return list;
    } else {
      myPrint('file on drive found');
      final driveId = result.files!.first.id!;
      myPrint('driveId $driveId');
      var finalData = <PasswordModel>[];
      if (sync == SyncEnum.push) {
        finalData = list;
      } else if (sync == SyncEnum.pull || sync == SyncEnum.merge) {
        final lastData = await getLastData(driveId, account, driveApi);
        finalData = lastData;
        if (sync == SyncEnum.merge) {
          finalData = [...list, ...lastData].toSet().toList();
        }
      }
      final jsonString = jsonEncode(finalData.map((e) => e.toJson()).toList());
      final encoded = _encryptDataService.encode(jsonString);
      myPrint(encoded);
      final media = _toMedia(encoded);

      await driveApi.files.update(
        file,
        driveId,
        uploadMedia: media,
      );
      return finalData;
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
    final jsonString = await utf8.decodeStream(result.stream);
    print("jsonString => $jsonString"); //Finally you have your text
    final jsonMap = json.decode(_encryptDataService.decode(jsonString));
    print("jsonMap => $jsonMap");
    if (!(jsonMap is List)) {
      throw "Result Not List";
    }
    return jsonMap.map((e) => PasswordModel.fromJson(e)).toList();
  }

  String _fileName(
    GoogleSignInAccount account,
  ) {
    return "protect_${account.email}.txt";
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
