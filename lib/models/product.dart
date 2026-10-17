import 'package:flutter/material.dart';

class Product {
  Product({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.icon,
    required this.accent,
  });

  final String name;
  final double price;
  final String category;
  final String description;
  final IconData icon;
  final Color accent;
}
