import 'package:animated_login/login_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Login',
      themeMode: ThemeMode.dark,
      home: LoginScreen(),
    );
  }
}
