import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/data/comments.dart';
import 'package:nike_ecommerce_flutter/data/common/http_responce_validator.dart';

abstract class ICommentDtaSource {
  Future<List<CommentEntity>> getAll({required int productId});
  Future<CommentEntity> insert(String title, String content, int productId);
}

class CommentRemoteDataSource
    with HttpResponceValidator
    implements ICommentDtaSource {
  final Dio httpClient;

  CommentRemoteDataSource(this.httpClient);

  @override
  Future<List<CommentEntity>> getAll({required int productId}) async {
    final responce = await httpClient.get('comment/list?product_id=$productId');
    validateResponce(responce);

    final List<CommentEntity> comments = [];
    (responce.data as List).forEach((element) {
      comments.add(CommentEntity.fromJson(element));
    });

    return comments;
  }

  @override
  Future<CommentEntity> insert(
      String title, String content, int productId) async {
    final responce = await httpClient.post('comment/add',data: {"title": title, "content": content, "product_id": productId});
    validateResponce(responce);
    return CommentEntity.fromJson(responce.data);
  }
}
