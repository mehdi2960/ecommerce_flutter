import 'package:dio/dio.dart';

final httpClient = Dio(
  BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'),
);