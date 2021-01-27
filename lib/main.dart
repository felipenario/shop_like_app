import 'package:flutter/material.dart';
import 'package:shop_like_app/utils/app_routes.dart';
import 'package:shop_like_app/views/home_screen.dart';
import 'package:shop_like_app/views/smartphone_form_screen.dart';
import 'package:shop_like_app/views/smartphone_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff11001C),
        accentColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            labelStyle: TextStyle(
                color: Color(0xff11001C).withOpacity(1)
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(20)
              ),
            ),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(20)
                ),
                borderSide: BorderSide(color: Color(0xff11001C))
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(20)
                ),
                borderSide: BorderSide(color: Color(0xff11001C))
            ),
          ),
      ),
      routes: {
        AppRoutes.HOME_SCREEN: (ctx) => HomeScreen(),
        AppRoutes.SMARTPHONE_SCREEN: (ctx) => SmartphoneScreen(),
        AppRoutes.SMARTPHONE_FORM_SCREEN: (ctx) => SmartphoneFormScreen()
      },
    );
  }
}

