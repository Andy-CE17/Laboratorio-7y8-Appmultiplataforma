import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/app_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/ui_helpers.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettings.instance;
    return AnimatedBuilder(
      animation: settings,
      builder: (context, child) => Scaffold(
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
              child: InkWell(
                onTap: () => _pickAvatar(context),
                borderRadius: BorderRadius.circular(70),
                child: Stack(
                  children: [
                    Container(
                      width: 116,
                      height: 116,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: settings.avatarBytes == null
                            ? const Image(
                                image: AssetImage(
                                  'assets/images/profile_avatar.png',
                                ),
                                fit: BoxFit.cover,
                              )
                            : Image.memory(
                                settings.avatarBytes!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 2,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: const Icon(Icons.camera_alt, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              settings.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 5),
            Text(
              settings.email,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 30),
            DarkCard(
              onTap: () => _editProfile(context),
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
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: settings.notificationsEnabled,
                    onChanged: settings.updateNotifications,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 13),
            DarkCard(
              onTap: () => _chooseTheme(context),
              child: _SettingRow(
                icon: Icons.palette_outlined,
                title: 'Tema de color',
                subtitle: 'Personaliza el color de la aplicación',
                trailing: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: settings.accent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 13),
            DarkCard(
              onTap: () => showAboutDialog(
                context: context,
                applicationName: 'Sistema de Productos',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(
                  Icons.inventory_2_outlined,
                  size: 42,
                ),
                children: const [Text('Aplicación de los laboratorios 7 y 8.')],
              ),
              child: const _SettingRow(
                icon: Icons.info_outline,
                title: 'Acerca de',
                subtitle: 'Información de la aplicación',
              ),
            ),
            const SizedBox(height: 28),
            OutlinedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar sesión'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size.fromHeight(54),
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAvatar(BuildContext context) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1000,
    );
    if (image == null) return;
    AppSettings.instance.updateAvatar(await image.readAsBytes());
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto de perfil actualizada')),
      );
    }
  }

  Future<void> _editProfile(BuildContext context) async {
    final settings = AppSettings.instance;
    final nameController = TextEditingController(text: settings.name);
    final emailController = TextEditingController(text: settings.email);
    final formKey = GlobalKey<FormState>();

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar perfil'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Ingresa tu nombre'
                    : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: (value) => value == null || !value.contains('@')
                    ? 'Ingresa un correo válido'
                    : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (saved == true) {
      settings.updateProfile(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
      );
    }
    nameController.dispose();
    emailController.dispose();
  }

  void _chooseTheme(BuildContext context) {
    const colors = [
      Color(0xFFFF5A0A),
      Color(0xFF8B5CF6),
      Color(0xFF1687FF),
      Color(0xFF16A878),
    ];
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Elige un tema',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: colors
                    .map(
                      (color) => InkWell(
                        onTap: () {
                          AppSettings.instance.updateAccent(color);
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
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
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;

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
        trailing ?? const Icon(Icons.chevron_right, color: AppColors.muted),
      ],
    );
  }
}
