import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/data/comments.dart';
import 'package:nike_ecommerce_flutter/data/repo/comment_repository.dart';
import 'package:nike_ecommerce_flutter/ui/product/comment/bloc/comment_list_bloc_bloc.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/error.dart';

class CommentList extends StatelessWidget {
  final int productId;
  const CommentList({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentListBloc bloc =
            CommentListBloc(commentRepository, productId);
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListSuccess) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CommentItem(
                    comment: state.comments[index],
                  );
                },
                childCount: state.comments.length,
              ),
            );
          } else if (state is CommentListLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CommentListError) {
            return SliverToBoxAdapter(
              child: AppErrorWidget(
                exception: state.exception,
                onPress: () {
                  BlocProvider.of<CommentListBloc>(context)
                      .add(CommentListStarted());
                },
              ),
            );
          } else {
            throw Exception('state is not supported');
          }
        },
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  const CommentItem({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.title),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    comment.email,
                    style: theme.textTheme.caption,
                  ),
                ],
              ),
              Text(
                comment.date,
                style: theme.textTheme.caption,
              ),
            ],
          ),
          const SizedBox(
            height: 17,
          ),
          Text(comment.content),
        ],
      ),
    );
  }
}
