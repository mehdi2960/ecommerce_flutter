part of 'insert_comment_bloc.dart';

abstract class InsertCommentState extends Equatable {
  const InsertCommentState();

  @override
  List<Object> get props => [];
}

class InsertCommentInitial extends InsertCommentState {}

class InsertCommentError extends InsertCommentState {
  final AppException exception;

  const InsertCommentError(this.exception);

  @override
  List<Object> get props => [exception];
}

class InsertCommentLoading extends InsertCommentState {}

class InsertCommentSuccess extends InsertCommentState {
  final CommentEntity commentEntity;
  final String message;

  const InsertCommentSuccess(this.commentEntity, this.message);
  @override
  List<Object> get props => [commentEntity,message];
}
