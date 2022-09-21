import 'package:nike_ecommerce_flutter/common/http_client.dart';
import 'package:nike_ecommerce_flutter/data/source/auth_data_source.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> register(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);

  @override
  Future<void> login(String username, String password) {
    return dataSource.login(username, password);
  }

  @override
  Future<void> register(String username, String password) {
    return dataSource.register(username, password);
  }

  @override
  Future<void> refreshToken() {
    return dataSource.refreshToken(
      "def502002b2b20208eaf88fee1f613e804242031f7f0fbe1370df9a7ca7c29dabe55ee05388db9a0e7b644de03eda89292a68ab8ad48513c84501a7061dc6911496881bc44d95e502c15e8e3102ec9b9fcabcecb02e30c69b026bad9553325323f20779eadedd99908847d31085fd32df0822623e252e200b1b91a1eabd9be45365103b9be09e1b6dd571bc4e3889975f9b78fe8e2ce3171a483507036741d63b61c4429e0a3306ef48b0c115e96a35e2e4bb152d71c6d69f267130f4882f796d61a526b28f4475858265722c2e9b40482ef20834550cf26844476dae9dd745a3d990825f728774fbcd474e73760d075cc2108ffc31237d771df75ecf1793eaf59de6250c9ace9280bd275767a30cc667bd7ed127924149fd768b11e93d54af191ac5860203fc31b09327e072ac2f542e357b31859536d2dccc234f3e7e461de3cef2739600253acde104d06af3189102ec6d097c9146edb81f1e350b7dbda8f",
    );
  }
}
