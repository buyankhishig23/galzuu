import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioManager {
  static DioManager? _instance;

  static DioManager get instance {
    if (_instance != null) return _instance!;
    _instance = DioManager._init();
    return _instance!;
  }

  final String _privateUrl = 'https://api.careerx.mn';

  late final Dio dio;

  DioManager._init() {
    dio = Dio(
      BaseOptions(
        baseUrl: _privateUrl,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (e, handler) async {
          var statusCode = e.response?.statusCode;

          if (statusCode == 400) {
            debugPrint('statusCode: $statusCode');
          }
          return handler.next(e);
        },
      ),
    );
  }
}
