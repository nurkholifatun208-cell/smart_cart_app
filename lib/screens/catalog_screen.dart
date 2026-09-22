import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../providers/cart_provider.dart';
import '../models/product.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Wardah Lipstick',
      price: 55000,
      description: 'Lipstik matte tahan lama dengan warna natural.',
      imageUrl: 'assets/images/Wardah_Lipstick.jpg',
    ),
    Product(
      id: '2',
      name: 'Timephoria',
      price: 129000,
      description: 'Parfum dengan aroma manis segar yang tahan seharian.',
      imageUrl: 'assets/images/Timephoria.jpg',
    ),
    Product(
      id: '3',
      name: 'Love Puff',
      price: 20000,
      description: 'Cushion ringan untuk hasil akhir wajah glowing mulus.',
      imageUrl: 'assets/images/Love_Puff.jpg',
    ),
    Product(
      id: '4',
      name: 'Y2K Clip',
      price: 18000,
      description: 'Jepitan rambut aesthetic gaya tren Y2K.',
      imageUrl: 'assets/images/Y2K_Clip.jpg',
    ),
  ];

  static const primaryPink = Color(0xFFFF6B8B);
  static const bgPink = Color(0xFFFFF0F3);

  String _formatCurrency(double price) {
    String priceStr = price.toStringAsFixed(0);
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return priceStr.replaceAllMapped(reg, (Match m) => '${m[1]}.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPink,
      appBar: AppBar(
        backgroundColor: bgPink,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'GlowyPaws ',
                  style: TextStyle(
                    color: primaryPink,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text('✨', style: TextStyle(fontSize: 18)),
              ],
            ),
            const Text(
              'cute beauty & stuff',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: primaryPink),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    if (cart.itemCount == 0) return const SizedBox.shrink();
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: primaryPink,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cart.itemCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.70,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _products.length,
        itemBuilder: (ctx, i) {
          final product = _products[i];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: primaryPink.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: product.imageUrl.startsWith('assets/')
                            ? Image.asset(product.imageUrl, fit: BoxFit.contain,
                                errorBuilder: (c, e, s) => const Icon(Icons.broken_image, color: Colors.grey))
                            : Image.file(File(product.imageUrl), fit: BoxFit.contain,
                                errorBuilder: (c, e, s) => const Icon(Icons.broken_image, color: Colors.grey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Rp ${_formatCurrency(product.price)}',
                          style: const TextStyle(color: primaryPink, fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false).addItem(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} ditambahkan ke keranjang!'),
                            backgroundColor: primaryPink,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryPink,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text('Add to Bag +', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}