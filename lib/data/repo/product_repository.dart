import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/data/product.dart';
import 'package:nike_ecommerce_flutter/data/source/product_data_source.dart';

final httpClient = Dio(
  BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'),
);

final productRepository = ProductRepository(ProductRemoteDataSource(httpClient));

abstract class IProductRepository {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository(this.dataSource);

  @override
  Future<List<ProductEntity>> getAll(int sort) {
    return dataSource.getAll(sort);
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) {
    return dataSource.search(searchTerm);
  }
}
