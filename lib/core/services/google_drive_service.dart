import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:http/http.dart' as http;

final googleDriveService = Provider<GoogleDriveService>((ref) {
  return GoogleDriveService();
});

class GoogleDriveService {
  void checkApi(GoogleSignInAccount account) async {
    final authHeader = await account.authHeaders;
    final authenticateClient = _GoogleAuthClient(authHeader);
    final driveApi = DriveApi(authenticateClient);
    final Stream<List<int>> mediaStream =
        Future.value([104, 105]).asStream().asBroadcastStream();
    var media = new Media(mediaStream, 2);
    var driveFile = new File();
    driveFile.name = "hello_world.txt";
    final result = await driveApi.files.create(driveFile, uploadMedia: media);
    print("Upload result: $result");
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
