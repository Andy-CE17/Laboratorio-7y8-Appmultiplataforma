import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/app_viewport.dart';

void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Productos',
      theme: AppTheme.theme,
      builder: (context, child) => AppViewport(child: child!),
      home: const LoginScreen(),
    );
  }
}
