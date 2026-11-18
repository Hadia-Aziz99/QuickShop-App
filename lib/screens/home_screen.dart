import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/product_data.dart';
import 'product_details_screen.dart';
import 'add_product_screen.dart';
import 'webview_screen.dart';
import 'gestures_screen.dart';

/// Requirement 2 & 5: Home Screen, Navigation Drawer, and 5 Gestures on Product Cards
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Electronics', 'Gadgets', 'Footwear', 'Accessories'];
  final Map<String, IconData> _categoryIcons = const {
    'All': Icons.grid_view_rounded,
    'Electronics': Icons.headphones_outlined,
    'Gadgets': Icons.watch_outlined,
    'Footwear': Icons.directions_run_outlined,
    'Accessories': Icons.shopping_bag_outlined,
  };

  String _searchQuery = '';
  bool _bannerExpanded = false;

  List<Product> get _filteredProducts {
    return productList.where((p) {
      final matchCat = _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchQuery = p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchCat && matchQuery;
    }).toList();
  }

  int get _favoriteCount => productList.where((p) => p.isFavorite).length;

  Widget _buildProductThumbnail(Product product) {
    if (product.localImagePath != null && File(product.localImagePath!).existsSync()) {
      return Image.file(File(product.localImagePath!), fit: BoxFit.cover, errorBuilder: (c, e, s) => _fallback(product.fallbackIcon));
    }
    return Image.network(
      product.imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (c, child, p) => p == null
          ? child
          : const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF7C3AED)),
              ),
            ),
      errorBuilder: (c, e, s) => _fallback(product.fallbackIcon),
    );
  }

  Widget _fallback(IconData icon) => Center(child: Icon(icon, size: 28, color: const Color(0xFF94A3B8)));

  Widget _drawerTile(IconData icon, String title, VoidCallback onTap, {Widget? trailing, String? subtitle}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF7C3AED)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0F172A), fontSize: 13.5)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F172A), Color(0xFF4C1D95), Color(0xFF7C3AED)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Row(
          children: [
            Icon(Icons.shopping_bag_outlined, size: 22, color: Color(0xFFEDE9FE)),
            SizedBox(width: 8),
            Text('QuickShop', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.3)),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                tooltip: 'Favourites',
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$_favoriteCount item(s) in favourites'),
                    backgroundColor: const Color(0xFF0F172A),
                    duration: const Duration(seconds: 1),
                  ),
                ),
              ),
              if (_favoriteCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text('$_favoriteCount', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
            tooltip: 'Add Product',
            onPressed: () async {
              final added = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProductScreen()));
              if (added == true) setState(() {});
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF1E1B4B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 36, color: Color(0xFFEDE9FE)),
                  SizedBox(height: 8),
                  Text('QuickShop', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('Mobile Computing Assignment 1 (20 Marks)', style: TextStyle(fontSize: 11, color: Color(0xFFCBD5E1))),
                ],
              ),
            ),
            _drawerTile(Icons.home_outlined, 'Home', () => Navigator.pop(context)),
            _drawerTile(
              Icons.grid_view_outlined,
              'Products',
              () => Navigator.pop(context),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(color: const Color(0xFFEDE9FE), borderRadius: BorderRadius.circular(6)),
                child: Text('${productList.length}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF7C3AED))),
              ),
            ),
            _drawerTile(Icons.add_box_outlined, 'Add Product', () async {
              Navigator.pop(context);
              final added = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProductScreen()));
              if (added == true) setState(() {});
            }),
            _drawerTile(Icons.language_outlined, 'WebView', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const WebViewScreen()));
            }, subtitle: 'In-app web portal'),
            _drawerTile(Icons.touch_app_outlined, 'Gestures & Animation', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const GesturesScreen()));
            }, subtitle: '5 gestures, animations & counter'),
            const Divider(color: Color(0xFFE2E8F0)),
            _drawerTile(Icons.info_outline, 'About QuickShop', () {
              Navigator.pop(context);
              showAboutDialog(context: context, applicationName: 'QuickShop', applicationVersion: '1.0.0');
            }),
          ],
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Improved Search Bar Design
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(Icons.search, size: 20, color: Color(0xFF7C3AED)),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (val) => setState(() => _searchQuery = val),
                          decoration: const InputDecoration(
                            hintText: 'Search products by name or details...',
                            hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      if (_searchQuery.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.clear, size: 16, color: Color(0xFF64748B)),
                          onPressed: () => setState(() => _searchQuery = ''),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Requirement 6: Animated Promotional Banner with Shopping Image
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: GestureDetector(
                  onTap: () => setState(() => _bannerExpanded = !_bannerExpanded),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F172A), Color(0xFF2E1065)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C3AED).withValues(alpha: 0.18),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEDE9FE),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'SPECIAL OFFER',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF7C3AED)),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                '20% OFF',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'On trending gadgets & footwear',
                                style: TextStyle(fontSize: 11, color: Color(0xFFCBD5E1)),
                              ),
                              if (_bannerExpanded) ...[
                                const SizedBox(height: 6),
                                const Text(
                                  'Promo code: QUICK20 (Tap to apply)',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFA78BFA)),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Attractive Product Image inside Banner
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300&q=80',
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => const Icon(Icons.shopping_bag_outlined, size: 40, color: Color(0xFFEDE9FE)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Category Chips with Attractive Material Icons
            SliverToBoxAdapter(
              child: SizedBox(
                height: 42,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  itemCount: _categories.length,
                  itemBuilder: (_, i) {
                    final cat = _categories[i];
                    final isSel = cat == _selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        avatar: Icon(
                          _categoryIcons[cat] ?? Icons.category,
                          size: 15,
                          color: isSel ? Colors.white : const Color(0xFF7C3AED),
                        ),
                        label: Text(cat),
                        selected: isSel,
                        selectedColor: const Color(0xFF7C3AED), // Rich purple accent
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSel ? Colors.white : const Color(0xFF0F172A),
                          fontSize: 11.5,
                          fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        side: BorderSide(color: isSel ? const Color(0xFF7C3AED) : const Color(0xFFE2E8F0)),
                        onSelected: (s) => setState(() => _selectedCategory = cat),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Section Header (Products count + Gestures indicator)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Products (${_filteredProducts.length})', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    const Row(
                      children: [
                        Icon(Icons.touch_app_outlined, size: 14, color: Color(0xFF7C3AED)),
                        SizedBox(width: 4),
                        Text('5 Gestures Active', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF7C3AED))),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Medium-sized Compact Product Cards Grid (childAspectRatio: 0.88)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.88, // Medium compact proportion for balanced look
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _buildProductCard(_filteredProducts[i]),
                  childCount: _filteredProducts.length,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          final added = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProductScreen()));
          if (added == true) setState(() {});
        },
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Medium-sized Compact Product Card with All 5 Gestures & Subtle Feedback
  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product))).then((_) => setState(() {})),
      onDoubleTap: () {
        setState(() => product.isFavorite = !product.isFavorite);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(product.isFavorite ? '❤️ Added ${product.name} to favourites' : 'Removed from favourites'),
            duration: const Duration(milliseconds: 900),
            backgroundColor: const Color(0xFF0F172A),
          ),
        );
      },
      onLongPress: () => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(product.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          content: Text('${product.description}\n\nPrice: \$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 13, color: Color(0xFF475569))),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK', style: TextStyle(color: Color(0xFF7C3AED), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      onHorizontalDragEnd: (d) {
        final dir = (d.primaryVelocity ?? 0) < 0 ? 'Left' : 'Right';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('↔️ Horizontal swipe ($dir) on ${product.name}'),
            duration: const Duration(milliseconds: 700),
            backgroundColor: const Color(0xFF0F172A),
          ),
        );
      },
      onVerticalDragEnd: (d) {
        final dir = (d.primaryVelocity ?? 0) < 0 ? 'Up' : 'Down';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('↕️ Vertical swipe ($dir) on ${product.name}'),
            duration: const Duration(milliseconds: 700),
            backgroundColor: const Color(0xFF0F172A),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with top-right favourite badge
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                    child: Container(
                      width: double.infinity,
                      color: const Color(0xFFF8FAFC),
                      child: _buildProductThumbnail(product),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () => setState(() => product.isFavorite = !product.isFavorite),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.95),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          product.isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 15,
                          color: product.isFavorite ? const Color(0xFFEF4444) : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product info & Add button
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${product.name} to cart!'),
                              backgroundColor: const Color(0xFF0F172A),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C3AED), // Rich purple button
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shopping_cart_outlined, size: 11, color: Colors.white),
                              SizedBox(width: 3),
                              Text('Add', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
