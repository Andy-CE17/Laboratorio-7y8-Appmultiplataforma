import 'package:flutter/material.dart';

import 'data/app_settings.dart';
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
    return AnimatedBuilder(
      animation: AppSettings.instance,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sistema de Productos',
        theme: AppTheme.theme(AppSettings.instance.accent),
        builder: (context, child) => AppViewport(child: child!),
        home: const LoginScreen(),
      ),
    );
  }
}
