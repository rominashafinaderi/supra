import 'package:flutter/material.dart';
import 'package:supra/colors.dart';
import 'package:supra/screen/login_screen.dart';
import 'package:supra/screen/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:  LoginScreen(),
    );
  }
}

