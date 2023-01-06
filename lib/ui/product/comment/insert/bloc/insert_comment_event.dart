part of 'insert_comment_bloc.dart';

abstract class InsertCommentEvent extends Equatable {
  const InsertCommentEvent();

  @override
  List<Object> get props => [];
}

class InsertCommentForSubmit extends InsertCommentEvent {
  final String title;
  final String content;

  const InsertCommentForSubmit(this.title, this.content);

  @override
  List<Object> get props => [title,content];
}
