import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'main_navigation.dart';

void main() {
  runApp(const ClinGaitApp());
}

class ClinGaitApp extends StatelessWidget {
  const ClinGaitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClinGait AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigation(),
    );
  }
}
