import 'package:flutter/material.dart';

/// Product model for QuickShop
class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String? localImagePath;
  final IconData fallbackIcon;
  final String category;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.localImagePath,
    this.fallbackIcon = Icons.shopping_bag_outlined,
    this.category = 'General',
    this.isFavorite = false,
  });
}
