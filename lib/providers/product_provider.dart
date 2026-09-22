import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      name: 'Love Puff',
      price: 45000,
      description: 'Puff bedak yang lembut dan imut.',
      imageUrl: 'assets/Love_Puff.jpg',
    ),
    Product(
      id: 'p2',
      name: 'Timephoria',
      price: 120000,
      description: 'Parfum dengan wangi tahan lama.',
      imageUrl: 'assets/Timephoria.jpg',
    ),
  ];

  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  // Fungsi untuk menghapus menu produk dari katalog
  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}