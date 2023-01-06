import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/data/repo/comment_repository.dart';
import 'package:nike_ecommerce_flutter/ui/product/comment/insert/bloc/insert_comment_bloc.dart';

class InsertCommentDialog extends StatefulWidget {
  const InsertCommentDialog(
      {super.key, required this.productId, this.scaffoldMessenger});
  final int productId;
  final ScaffoldMessengerState? scaffoldMessenger;

  @override
  State<InsertCommentDialog> createState() => _InsertCommentDialogState();
}

class _InsertCommentDialogState extends State<InsertCommentDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  StreamSubscription? subscription;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = InsertCommentBloc(commentRepository, widget.productId);
        subscription = bloc.stream.listen((state) {
          if (state is InsertCommentSuccess) {
              widget.scaffoldMessenger?.showSnackBar(
                SnackBar(content: Text(state.message)));
            Navigator.of(context, rootNavigator: true).pop();
          } else if (state is InsertCommentError) {
            widget.scaffoldMessenger?.showSnackBar(
                SnackBar(content: Text(state.exception.message)));
            Navigator.of(context,rootNavigator: true).pop();
          }
        });
        return bloc;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 300,
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<InsertCommentBloc, InsertCommentState>(
            builder: (context, state) {
              return Column(
                children: [
                  const Text(
                    'ثبت نظر',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      label: Text('عنوان'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      label: Text('متن نظر خود را اینجا وارد کنید'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size.fromHeight(56),
                      ),
                    ),
                    onPressed: () {
                      context.read<InsertCommentBloc>().add(
                          InsertCommentForSubmit(
                              _titleController.text, _contentController.text));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is InsertCommentError)
                          const CupertinoActivityIndicator(),
                        const Text(
                          'ذخیره',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
