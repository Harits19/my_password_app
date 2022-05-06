import 'package:get_it/get_it.dart';
import 'package:my_password_app/core/services/local_auth_service.dart';
import 'package:my_password_app/core/services/secure_storage_service.dart';
import 'package:my_password_app/services/password_api.dart';

Future<void> setupDepedencyInjection() async {
  GetIt.I.registerSingleton<PasswordApi>(PasswordApi());
  GetIt.I.registerSingleton<LocalAuthServiceV2>(LocalAuthServiceV2());
  GetIt.I.registerSingleton<SecureStorageV2>(SecureStorageV2());

  // GetIt.I
  //     .registerSingletonAsync<WishlistRepo>(() async => WishlistRepo().init());
  await GetIt.I.allReady();
}
