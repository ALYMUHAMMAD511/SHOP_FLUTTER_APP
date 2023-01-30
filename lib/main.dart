import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'modules/on boarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const OnboardingScreen(),
    );
  }
}