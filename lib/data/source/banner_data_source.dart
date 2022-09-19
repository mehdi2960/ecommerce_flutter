import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/data/banner.dart';
import 'package:nike_ecommerce_flutter/data/common/http_responce_validator.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource
    with HttpResponceValidator
    implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);

  @override
  Future<List<BannerEntity>> getAll() async {
    final responce = await httpClient.get('banner/slider');
    validateResponce(responce);
    final List<BannerEntity> banners = [];
    (responce.data as List).forEach((jsonObject) {
      banners.add(BannerEntity.fromJson(jsonObject));
    });

    return banners;
  }
}
