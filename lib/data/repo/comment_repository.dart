import 'package:nike_ecommerce_flutter/common/http_client.dart';
import 'package:nike_ecommerce_flutter/data/comments.dart';
import 'package:nike_ecommerce_flutter/data/source/comment_data_source.dart';

final commentRepository = CommentRepository(
  CommentRemoteDataSource(httpClient),
);

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDtaSource dataSource;

  CommentRepository(this.dataSource);
  @override
  Future<List<CommentEntity>> getAll({required int productId}) {
    return dataSource.getAll(productId: productId);
  }
}
