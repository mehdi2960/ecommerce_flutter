import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(top: 32, bottom: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              child: Image.asset('assets/img/nike_logo.png'),
            ),
            const Text('mehdiprogrammer30@gmail.com'),
            const SizedBox(
              height: 32,
            ),
            const Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                height: 56,
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.heart),
                    SizedBox(
                      width: 16,
                    ),
                    Text('لیست علاقه مندی ها'),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                height: 56,
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.cart),
                    SizedBox(
                      width: 16,
                    ),
                    Text('سوابق سفارش'),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title:
                            Text('خروج از حساب کاربری'),
                            content:Text('آیا می خواهید از حساب کاربری خود خارج شوید؟')

                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                height: 56,
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.arrow_right_square),
                    SizedBox(
                      width: 16,
                    ),
                    Text('خروچ از حساب کاربری'),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
