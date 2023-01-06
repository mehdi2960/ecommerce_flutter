import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InsertCommentDialog extends StatefulWidget {
  const InsertCommentDialog({super.key});

  @override
  State<InsertCommentDialog> createState() => _InsertCommentDialogState();
}

class _InsertCommentDialogState extends State<InsertCommentDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('ثبت نظر',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
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
              onPressed: () {},
              child: const Text('ذخیره',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }
}
