import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/data/cart_item.dart';
import 'package:nike_ecommerce_flutter/data/cart_responce.dart';

abstract class ICartDataSource {
  Future<CartResponce> add(int productId);
  Future<CartResponce> changeCart(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<List<CartItemEntity>> getAll();
}

class CartRemoteDataSource implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);

  @override
  Future<CartResponce> add(int productId) async {
    final responce =  await httpClient.post('cart/add', data: {'product_id': productId});

    return CartResponce.froJson(responce.data);
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
