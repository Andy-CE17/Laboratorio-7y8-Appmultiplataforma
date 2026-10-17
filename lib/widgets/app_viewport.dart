import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppViewport extends StatelessWidget {
  const AppViewport({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 620) {
          return child;
        }

        final phoneHeight = math.min(constraints.maxHeight - 40, 860.0);
        return ColoredBox(
          color: const Color(0xFF6A584B),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.4,
                colors: [
                  Color(0xFF9C8471),
                  Color(0xFF5E4C40),
                  Color(0xFF2B2928),
                ],
              ),
            ),
            child: Center(
              child: Container(
                width: 430,
                height: phoneHeight,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(48),
                  border: Border.all(color: const Color(0xFF6D7478), width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 30,
                      offset: Offset(0, 14),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
