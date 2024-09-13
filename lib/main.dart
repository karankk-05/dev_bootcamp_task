
import 'package:flutter/material.dart';

import 'entry_page.dart';
import 'themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bootcamp',
      theme: appthemes.lighttheme,
      home: const OnboardingWidget(),
    );
  }
}
