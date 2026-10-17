import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laboratorio_productos/main.dart';

void main() {
  testWidgets('muestra la pantalla de inicio de sesión', (tester) async {
    await tester.pumpWidget(const ProductApp());

    expect(find.text('Sistema de'), findsOneWidget);
    expect(find.text('Productos'), findsOneWidget);
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });

  testWidgets('permite navegar por todas las pantallas', (tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProductApp());

    final fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), 'admin@demo.com');
    await tester.enterText(fields.at(1), '123456');
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Hola, Andy'), findsOneWidget);

    await tester.tap(find.text('Productos'));
    await tester.pumpAndSettle();
    expect(find.text('Lista de productos registrados'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Registrar producto'));
    await tester.pumpAndSettle();
    expect(find.text('GUARDAR PRODUCTO'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Perfil / Configuración'));
    await tester.pumpAndSettle();
    expect(find.text('Editar perfil'), findsOneWidget);
    expect(find.text('Tema de color'), findsOneWidget);
  });
}
