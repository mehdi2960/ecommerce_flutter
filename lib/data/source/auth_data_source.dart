import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/common/constants.dart';
import 'package:nike_ecommerce_flutter/data/auth_info.dart';
import 'package:nike_ecommerce_flutter/data/common/http_responce_validator.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String password);
  Future<AuthInfo> register(String username, String password);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource
    with HttpResponceValidator
    implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource(this.httpClient);

  @override
  Future<AuthInfo> login(String username, String password) async {
    final responce = await httpClient.post("auth/token", data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constants.clientSecret,
      "username": username,
      "password": password
    });

    validateResponce(responce);

    return AuthInfo(
      responce.data["access_token"],
      responce.data["refresh_token"],
      username
    );
  }

  @override
  Future<AuthInfo> refreshToken(String token) async {
    final responce = await httpClient.post('auth/token', data: {
      "grant_type": "refresh_token",
      "refresh_token": token,
      "client_id": 2,
      "client_secret": Constants.clientSecret,
    });

    validateResponce(responce);
    return AuthInfo(
      responce.data['access_token'],
      responce.data['refresh_token'],
      ''
    );
  }

  @override
  Future<AuthInfo> register(String username, String password) async {
    final responce = await httpClient.post('user/register', data: {
      "email": username,
      "password": password,
    });

    validateResponce(responce);
    return login(username, password);
  }
}
