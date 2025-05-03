import 'package:dio/dio.dart';
import 'package:fidooo_chat/shared/constants/env_keys.dart';
import 'package:fidooo_chat/shared/services/local_storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  final LocalStorageService localStorageService;
  final Dio dio;

  DioClient(this.localStorageService)
    : dio = Dio(
        BaseOptions(
          baseUrl: dotenv.env[EnvKeys.apiUrl] ?? "",
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.headers.containsKey("no-auth")) {
            options.headers.remove("no-auth");
          } else {
            final token = localStorageService.getToken();
            options.headers.addAll({"Authorization": "Bearer $token"});
          }
          return handler.next(options);
        },
      ),
    );
  }
}
