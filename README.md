# Sistema de Productos

Aplicación Flutter desarrollada para los laboratorios 7 y 8 del curso de Aplicaciones Móviles Multiplataforma.

## Funciones

- Inicio de sesión con validación.
- Menú principal conectado con todas las secciones.
- ListView de productos con búsqueda y contador.
- Registro de productos con validación de campos.
- Almacenamiento temporal en memoria durante la ejecución.
- Perfil y configuración del usuario.
- Cierre de sesión y retorno al Login.

## Usuario de prueba

```text
Correo: admin@demo.com
Contraseña: 123456
```

## Estructura principal

```text
lib/
├── data/
├── models/
├── screens/
├── theme/
├── widgets/
└── main.dart
```

## Ejecución

```bash
flutter pub get
flutter run -d chrome
```

## Validación

```bash
flutter analyze
flutter test
flutter build web
```
