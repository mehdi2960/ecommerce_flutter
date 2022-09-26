import 'package:nike_ecommerce_flutter/common/http_client.dart';
import 'package:nike_ecommerce_flutter/data/add_to_cart_response.dart';
import 'package:nike_ecommerce_flutter/data/cart_item.dart';
import 'package:nike_ecommerce_flutter/data/cart_response.dart';
import 'package:nike_ecommerce_flutter/data/source/cart_data_source.dart';

final cartRepository = CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<AddToCartResponse> add(int productId);
  Future<AddToCartResponse> changeCart(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<CartResponse> getAll();
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);

  @override
  Future<AddToCartResponse> add(int productId) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<AddToCartResponse> changeCart(int cartItemId, int count) {
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
   return cartRepository.delete(cartItemId);
  }

  @override
  Future<CartResponse> getAll() {
    return dataSource.getAll();
  }
}
