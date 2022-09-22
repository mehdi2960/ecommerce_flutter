import 'package:nike_ecommerce_flutter/common/http_client.dart';
import 'package:nike_ecommerce_flutter/data/cart_item.dart';
import 'package:nike_ecommerce_flutter/data/cart_responce.dart';
import 'package:nike_ecommerce_flutter/data/source/cart_data_source.dart';

final cartRepository = CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<CartResponce> add(int productId);
  Future<CartResponce> changeCart(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<List<CartItemEntity>> getAll();
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);

  @override
  Future<CartResponce> add(int productId) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<CartResponce> changeCart(int cartItemId, int count) {
    // TODO: implement changeCart
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CartItemEntity>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
