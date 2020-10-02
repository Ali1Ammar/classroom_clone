import 'package:colleage/api/http_error.dart';
import 'package:dio/dio.dart';

class Client {
  static final dio = Dio(
    BaseOptions(baseUrl: "https://main-dz38oucjcuv7povq-gtw.qovery.io/"),
  )..interceptors.addAll([ErrorInterceptors()]);
}
