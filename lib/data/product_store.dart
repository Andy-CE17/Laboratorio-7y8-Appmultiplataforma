import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductStore {
  ProductStore._();

  static final ProductStore instance = ProductStore._();

  final List<Product> _products = [
    Product(
      name: 'Mesa de escritorio',
      price: 350,
      category: 'Muebles',
      description: 'Mesa de madera para oficina.',
      icon: Icons.desk_outlined,
      accent: const Color(0xFFFF5A0A),
    ),
    Product(
      name: 'Silla gamer',
      price: 450,
      category: 'Muebles',
      description: 'Silla ergonómica para largas sesiones.',
      icon: Icons.chair_alt_outlined,
      accent: const Color(0xFFB941F5),
    ),
    Product(
      name: 'Teclado mecánico',
      price: 250,
      category: 'Tecnología',
      description: 'Teclado mecánico con iluminación.',
      icon: Icons.keyboard_alt_outlined,
      accent: const Color(0xFFFFC229),
    ),
    Product(
      name: 'Monitor 24 pulgadas',
      price: 620,
      category: 'Tecnología',
      description: 'Monitor de alta definición.',
      icon: Icons.desktop_windows_outlined,
      accent: const Color(0xFFFFC229),
    ),
    Product(
      name: 'Mouse inalámbrico',
      price: 120,
      category: 'Tecnología',
      description: 'Mouse inalámbrico compacto.',
      icon: Icons.mouse_outlined,
      accent: const Color(0xFFFFC229),
    ),
  ];

  List<Product> get products => List.unmodifiable(_products);

  void add(Product product) {
    _products.add(product);
  }
}
