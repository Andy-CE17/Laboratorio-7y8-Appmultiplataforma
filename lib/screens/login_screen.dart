import 'package:flutter/material.dart';

import '../data/app_settings.dart';
import '../widgets/ui_helpers.dart';
import 'menu_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    if (_emailController.text.trim() != AppSettings.instance.email ||
        _passwordController.text != '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correo o contraseña incorrectos'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MenuScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F6),
      body: Stack(
        children: [
          Positioned(
            right: -80,
            top: 100,
            child: Transform.rotate(
              angle: .75,
              child: Container(
                width: 230,
                height: 230,
                color: const Color(0xFFEDEDEC),
              ),
            ),
          ),
          Positioned(
            right: -25,
            bottom: 20,
            child: Icon(
              Icons.laptop_mac_rounded,
              size: 150,
              color: Colors.grey.shade300,
            ),
          ),
          Positioned(
            right: 38,
            bottom: 92,
            child: Icon(
              Icons.local_florist_rounded,
              size: 90,
              color: Colors.green.shade700,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 62, 28, 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.lerp(accent, Colors.white, .12)!,
                            Color.lerp(accent, Colors.black, .18)!,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x44FF5A0A),
                            blurRadius: 22,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.inventory_2_outlined,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Sistema de',
                      style: TextStyle(
                        color: Color(0xFF202124),
                        fontSize: 31,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                    ),
                    Text(
                      'Productos',
                      style: TextStyle(
                        color: accent,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Gestiona y controla tus productos\nde forma sencilla.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF53565A),
                        fontSize: 16,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .86),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x16000000),
                            blurRadius: 25,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Color(0xFF202124)),
                            decoration: _lightInput(
                              hint: 'Correo electrónico',
                              icon: Icons.mail_outline,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Ingresa tu correo'
                                : null,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _hidePassword,
                            style: const TextStyle(color: Color(0xFF202124)),
                            decoration: _lightInput(
                              hint: 'Contraseña',
                              icon: Icons.lock_outline,
                              suffix: IconButton(
                                onPressed: () => setState(
                                  () => _hidePassword = !_hidePassword,
                                ),
                                icon: Icon(
                                  _hidePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xFF575A5E),
                                ),
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Ingresa tu contraseña'
                                : null,
                          ),
                          const SizedBox(height: 18),
                          OrangeButton(
                            label: 'Iniciar sesión',
                            onPressed: _login,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Usuario de prueba:',
                      style: TextStyle(color: Color(0xFF7A7D81)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${AppSettings.instance.email}\n123456',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF3E4145),
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _lightInput({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFD9DADC)),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF85898E)),
      prefixIcon: Icon(icon, color: const Color(0xFF575A5E)),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
      ),
    );
  }
}
