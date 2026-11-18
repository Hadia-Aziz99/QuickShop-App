import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../models/product.dart';
import '../data/product_data.dart';

/// Requirement 4: Add New Product Screen with validations and optional Image URL
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  String _selectedCategory = 'Electronics';
  final _categories = ['Electronics', 'Gadgets', 'Footwear', 'Accessories'];
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<String?> _downloadImageLocally(String url) async {
    try {
      final uri = Uri.tryParse(url);
      if (uri == null || !uri.hasScheme || !uri.scheme.startsWith('http')) return null;
      final request = await HttpClient().getUrl(uri);
      final response = await request.close();
      if (response.statusCode == 200) {
        final bytes = await response.fold<List<int>>([], (p, e) => p..addAll(e));
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/img_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await file.writeAsBytes(bytes);
        return file.path;
      }
    } catch (_) {}
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    final name = _nameController.text.trim();
    final price = double.parse(_priceController.text.trim());
    final desc = _descriptionController.text.trim();
    String url = _imageUrlController.text.trim();
    String? localPath;

    if (url.isNotEmpty) {
      localPath = await _downloadImageLocally(url);
    } else {
      url = 'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=600&q=80';
    }

    productList.add(Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      price: price,
      description: desc,
      category: _selectedCategory,
      imageUrl: url,
      localImagePath: localPath,
    ));

    if (mounted) {
      setState(() => _isSaving = false);
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _imageUrlController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 Product "$name" added successfully!'),
          backgroundColor: const Color(0xFF7C3AED),
        ),
      );
      Navigator.pop(context, true);
    }
  }

  // Colourful input decoration
  InputDecoration _inputDeco(String hint, {IconData? icon, Color iconColor = const Color(0xFF7C3AED)}) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
        prefixIcon: icon != null
            ? Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFDDD6FE))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF7C3AED), width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFEF4444))),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2)),
      );

  Widget _label(String text, {bool required = false}) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Text(text, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF0F172A), fontSize: 13.5)),
            if (required)
              const Text(' *', style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.bold)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(title: const Text('Add New Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C3AED), Color(0xFF4C1D95)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7C3AED).withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add_box_rounded, color: Colors.white, size: 32),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('New Product', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('Fill in the details below', style: TextStyle(color: Color(0xFFDDD6FE), fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),

              _label('Product Name', required: true),
              TextFormField(
                controller: _nameController,
                decoration: _inputDeco('e.g. Wireless Noise-Cancelling Headphones', icon: Icons.shopping_bag_outlined),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a product name' : null,
              ),
              const SizedBox(height: 14),

              _label('Product Price (\$)', required: true),
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _inputDeco('e.g. 59.99', icon: Icons.attach_money, iconColor: const Color(0xFF10B981)),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Please enter a price';
                  final p = double.tryParse(v.trim());
                  return (p == null || p <= 0) ? 'Enter a valid positive number' : null;
                },
              ),
              const SizedBox(height: 14),

              _label('Image URL (Optional)'),
              TextFormField(
                controller: _imageUrlController,
                decoration: _inputDeco('https://example.com/image.jpg', icon: Icons.image_outlined, iconColor: const Color(0xFF3B82F6)),
              ),
              const SizedBox(height: 14),

              _label('Category'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFDDD6FE), width: 1.5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF7C3AED)),
                    items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 13.5)))).toList(),
                    onChanged: (v) => setState(() => _selectedCategory = v!),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              _label('Product Description', required: true),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: _inputDeco('Enter product details and features...'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 28),

              // Submit button with gradient
              SizedBox(
                width: double.infinity,
                height: 52,
                child: GestureDetector(
                  onTap: _isSaving ? null : _submit,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isSaving
                            ? [const Color(0xFF94A3B8), const Color(0xFF64748B)]
                            : [const Color(0xFF7C3AED), const Color(0xFF4C1D95)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C3AED).withValues(alpha: 0.35),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isSaving)
                          const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        else
                          const Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          _isSaving ? 'Saving...' : 'Add Product',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
