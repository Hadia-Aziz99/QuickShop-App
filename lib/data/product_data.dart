import 'package:flutter/material.dart';
import '../models/product.dart';

/// In-memory Dart List storing all QuickShop products
List<Product> productList = [
  Product(
    id: '1',
    name: 'Wireless Headphones',
    price: 79.99,
    description:
        'High quality noise-cancelling wireless headphones with deep bass, soft ear cushions, and 24-hour battery life.',
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=80',
    fallbackIcon: Icons.headphones_outlined,
    category: 'Electronics',
  ),
  Product(
    id: '2',
    name: 'Smart Watch',
    price: 99.99,
    description:
        'Modern smart watch with fitness tracking, heart rate sensor, notifications, and water resistance.',
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&q=80',
    fallbackIcon: Icons.watch_outlined,
    category: 'Gadgets',
  ),
  Product(
    id: '3',
    name: 'Athletic Sneakers',
    price: 65.00,
    description:
        'Comfortable and lightweight running sneakers with breathable mesh upper and cushioned rubber sole.',
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80',
    fallbackIcon: Icons.directions_run_outlined,
    category: 'Footwear',
  ),
  Product(
    id: '4',
    name: 'Everyday Backpack',
    price: 49.99,
    description:
        'Durable water-resistant backpack featuring a dedicated laptop sleeve, front zip pocket, and padded straps.',
    imageUrl:
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&q=80',
    fallbackIcon: Icons.backpack_outlined,
    category: 'Accessories',
  ),
  Product(
    id: '5',
    name: 'Classic Sunglasses',
    price: 29.99,
    description:
        'Polarized sunglasses with lightweight frame and UV400 protective lenses.',
    imageUrl:
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=600&q=80',
    fallbackIcon: Icons.wb_sunny_outlined,
    category: 'Accessories',
  ),
  Product(
    id: '6',
    name: 'Bluetooth Speaker',
    price: 39.99,
    description:
        'Portable wireless speaker with 360-degree clear sound, waterproof exterior, and 12-hour battery life.',
    imageUrl:
        'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=600&q=80',
    fallbackIcon: Icons.speaker_outlined,
    category: 'Electronics',
  ),
];
