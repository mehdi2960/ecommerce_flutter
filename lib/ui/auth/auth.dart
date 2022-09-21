import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  final TextEditingController usernameController =
      TextEditingController(text: "test@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "123456");
  @override
  Widget build(BuildContext context) {
    const onBackground = Colors.white;
    final ThemeData themeData = Theme.of(context);
    return Theme(
      data: themeData.copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            minimumSize: MaterialStateProperty.all(
              const Size.fromHeight(56),
            ),
            backgroundColor: MaterialStateProperty.all(onBackground),
            foregroundColor:
                MaterialStateProperty.all(themeData.colorScheme.secondary),
          ),
        ),
        colorScheme: themeData.colorScheme.copyWith(onSurface: onBackground),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: onBackground),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: themeData.colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.only(right: 48, left: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/nike_logo.png',
                color: Colors.white,
                width: 120,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                isLogin ? "خوش آمدید" : 'ثبت نام',
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                isLogin
                    ? "لطفا وارد حساب کاربری خود شوید."
                    : 'ایمیل و رمز عبور خود را تعیین کنید',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text('آدرس ایمیل'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              _PasswordTextField(
                onBackground: onBackground,
                controller: passwordController,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  authRepository.login(
                    usernameController.text,
                    passwordController.text,
                  );
                },
                child: Text(isLogin ? 'ورود' : 'ثبت نام'),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin ? 'حساب کاربری ندارید؟' : 'حساب کاربری دارید؟',
                      style: TextStyle(
                        color: onBackground.withOpacity(.7),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      isLogin ? 'ثبت نام' : 'ورود',
                      style: TextStyle(
                        color: themeData.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    Key? key,
    required this.onBackground,
    required this.controller,
  }) : super(key: key);

  final Color onBackground;
  final TextEditingController controller;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    const onBackground = Colors.white;
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obsecureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obsecureText = !obsecureText;
            });
          },
          icon: Icon(
            obsecureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: onBackground,
          ),
        ),
        label: const Text('رمز عبور'),
      ),
    );
  }
}
