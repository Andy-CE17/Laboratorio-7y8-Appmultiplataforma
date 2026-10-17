import 'package:flutter_test/flutter_test.dart';
import 'package:laboratorio_productos/main.dart';

void main() {
  testWidgets('muestra la pantalla de inicio de sesión', (tester) async {
    await tester.pumpWidget(const ProductApp());

    expect(find.text('Sistema de'), findsOneWidget);
    expect(find.text('Productos'), findsOneWidget);
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });
}
