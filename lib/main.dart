import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/theme.dart';
import 'package:nike_ecommerce_flutter/ui/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      fontFamily: 'Yekan',
      color: LightThemeColors.primaryTextColor,
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondaryColor,
          onSecondary: Colors.white,
        ),
        textTheme: TextTheme(
          subtitle1: defaultTextStyle.apply(color: LightThemeColors.secondaryTextColor),
          bodyText2: defaultTextStyle,
          button: defaultTextStyle,
          caption: defaultTextStyle.apply(
            color: LightThemeColors.secondaryTextColor,
          ),
          headline6: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(),
      ),
    );
  }
}