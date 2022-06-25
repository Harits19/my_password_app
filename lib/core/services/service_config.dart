import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ServiceConfig {
  ServiceConfig._();

  static createInstance() {
    final options = BaseOptions(
      baseUrl: "http://",
      connectTimeout: 12000,
      receiveTimeout: 12000,
    );
    final dioInstance = Dio(options);
    dioInstance.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return dioInstance;
  }
}
