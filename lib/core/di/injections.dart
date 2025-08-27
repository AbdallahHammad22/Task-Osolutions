import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:osolutions_app/core/constants/app_endpoints.dart';
import 'package:osolutions_app/core/services/api_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initInj() async {
  SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  Dio dio = Dio();
  dio.options.baseUrl = AppEndPoints.baseUrl;
  dio.options.headers = {
    'Authorization': 'Bearer ${AppEndPoints.apiKey}',
    'apikey': AppEndPoints.apiKey,
    'Content-Type': 'application/json',
    'Prefer': 'return=representation',
  };
  dio.options.validateStatus = (status) =>
      true; // للسماح بمعالجة جميع رموز الحالة
  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );
  }
  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<ApiService>(ApiService(dio));
}
