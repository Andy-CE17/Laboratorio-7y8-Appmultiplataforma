import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/ui_helpers.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil / Configuración',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 26),
        children: [
          const SizedBox(height: 10),
          Center(
            child: Stack(
              children: [
                Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFDCE4E7), Color(0xFF52646D)],
                    ),
                    border: Border.all(color: AppColors.orange, width: 3),
                  ),
                  child: const Icon(Icons.person, size: 78),
                ),
                Positioned(
                  right: 0,
                  bottom: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.orange,
                    ),
                    child: const Icon(Icons.camera_alt, size: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Andy Campos',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 5),
          const Text(
            'admin@demo.com',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 30),
          DarkCard(
            onTap: () => _showMessage('Edición de perfil'),
            child: const _SettingRow(
              icon: Icons.edit_outlined,
              title: 'Editar perfil',
              subtitle: 'Actualiza tus datos personales',
            ),
          ),
          const SizedBox(height: 13),
          DarkCard(
            child: Row(
              children: [
                const Icon(Icons.notifications_outlined, size: 30),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notificaciones',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Alertas sobre productos',
                        style: TextStyle(color: AppColors.muted, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _notifications,
                  activeThumbColor: AppColors.orange,
                  onChanged: (value) => setState(() => _notifications = value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 13),
          DarkCard(
            onTap: () => _showMessage('La aplicación utiliza el tema oscuro'),
            child: const _SettingRow(
              icon: Icons.dark_mode_outlined,
              title: 'Apariencia',
              subtitle: 'Tema oscuro activado',
            ),
          ),
          const SizedBox(height: 13),
          DarkCard(
            onTap: () => _showMessage('Sistema de Productos v1.0'),
            child: const _SettingRow(
              icon: Icons.info_outline,
              title: 'Acerca de',
              subtitle: 'Información de la aplicación',
            ),
          ),
          const SizedBox(height: 28),
          OutlinedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.orange,
              minimumSize: const Size.fromHeight(54),
              side: const BorderSide(color: AppColors.orange),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 30),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(color: AppColors.muted, fontSize: 13),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: AppColors.muted),
      ],
    );
  }
}
