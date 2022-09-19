import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/data/product.dart';

import '../../common/exceptions.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);
  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final responce = await httpClient.get("product/list?sort=$sort");
    validateResponce(responce);
    final products = <ProductEntity>[];
    (responce.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });

    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final responce = await httpClient.get("product/search?q=$searchTerm");
    validateResponce(responce);
    final products = <ProductEntity>[];
    (responce.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });

    return products;
  }


  validateResponce(Response responce) {
    if (responce.statusCode != 200) {
      throw AppException();
    }
  }
}
