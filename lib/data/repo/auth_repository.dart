import 'package:flutter/cupertino.dart';
import 'package:nike_ecommerce_flutter/common/http_client.dart';
import 'package:nike_ecommerce_flutter/data/auth_info.dart';
import 'package:nike_ecommerce_flutter/data/source/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> register(String username, String password);
  Future<void> refreshToken();
  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  //!Start Baray Taghir Kardan Dadeha
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);
  //! End Baray Taghir Kardan Dadeha

  final IAuthDataSource dataSource;
  //  final SharedPreferences sharedPreferences;

  AuthRepository(this.dataSource);

//! Start Login Bodan Karbar
  static bool isUserLoggedIn() {
    return authChangeNotifier.value != null &&
        authChangeNotifier.value!.accessToken != null &&
        authChangeNotifier.value!.refreshToken.isNotEmpty;
  }
//! End Login Bodan Karbar

  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    _persistAuthTokens(authInfo);

    debugPrint("access token is: " + authInfo.accessToken);
    // return dataSource.login(username, password);
  }

  @override
  Future<void> register(String username, String password) async {
    final AuthInfo authInfo = await dataSource.register(username, password);
    _persistAuthTokens(authInfo);
    debugPrint("access token is: " + authInfo.accessToken);
    // return dataSource.register(username, password);
  }

  @override
  Future<void> refreshToken() async {
    if (authChangeNotifier.value != null) {
      final AuthInfo authInfo =
          await dataSource.refreshToken(authChangeNotifier.value!.refreshToken);
      // debugPrint('refresh token is: ${authInfo.refreshToken}');
      _persistAuthTokens(authInfo);
    }
  }

  //! Start Save Kardan Etelaat Token
  Future<void> _persistAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
    sharedPreferences.setString("email", authInfo.email);
    loadAuthInfo();
  }
  //! End Save Kardan Etelaat Token

  //! Start Khondan Etelaat
  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString("access_token") ?? '';
    final String refreshToken =
        sharedPreferences.getString("refresh_token") ?? '';

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthInfo(accessToken, refreshToken,
          sharedPreferences.getString("email") ?? "");
    }
  }
  //! End Khondan Etelaat

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
