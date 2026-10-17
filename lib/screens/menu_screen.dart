import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/ui_helpers.dart';
import 'login_screen.dart';
import 'product_form_screen.dart';
import 'products_screen.dart';
import 'profile_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF131C20), AppColors.background],
                ),
              ),
            ),
          ),
          Positioned(
            right: -45,
            bottom: 15,
            child: Icon(
              Icons.laptop_mac,
              size: 190,
              color: Colors.white.withValues(alpha: .04),
            ),
          ),
          PagePadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.menu_rounded, size: 34),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFCFD8DC), Color(0xFF455A64)],
                        ),
                        border: Border.all(color: Colors.white24, width: 2),
                      ),
                      child: const Icon(Icons.person, size: 54),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, Andy',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'admin@demo.com',
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      ),
                      icon: const Icon(Icons.chevron_right, size: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 38),
                _MenuCard(
                  title: 'Inicio',
                  subtitle: 'Panel principal',
                  icon: Icons.home_rounded,
                  selected: true,
                  onTap: () {},
                ),
                const SizedBox(height: 14),
                _MenuCard(
                  title: 'Productos',
                  subtitle: 'Ver productos registrados',
                  icon: Icons.inventory_2_outlined,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductsScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _MenuCard(
                  title: 'Registrar producto',
                  subtitle: 'Agregar nuevo producto',
                  icon: Icons.add_circle,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductFormScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _MenuCard(
                  title: 'Perfil / Configuración',
                  subtitle: 'Tu información y ajustes',
                  icon: Icons.person_outline,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _MenuCard(
                  title: 'Cerrar sesión',
                  subtitle: 'Salir del sistema',
                  icon: Icons.logout_rounded,
                  onTap: () => _logout(context),
                ),
              ],
            ),
          ),
        ],
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

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.selected = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
                    colors: [Color(0xFFC34612), Color(0xFF6B2714)],
                  )
                : null,
            color: selected ? null : AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? AppColors.orange : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 34, color: Colors.white),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
