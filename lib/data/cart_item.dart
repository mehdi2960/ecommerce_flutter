import 'package:nike_ecommerce_flutter/data/product.dart';

class CartItemEntity {
  final ProductEntity product;
  final int id;
  final int count;

  CartItemEntity.fromJson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json),
        id = json['cart_item_id'],
        count = json['count'];
}
