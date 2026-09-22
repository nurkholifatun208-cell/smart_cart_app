import 'dart:io';

class Product {
  String id;
  String name;
  double price;
  String imageUrl;
  File? localImageFile; // Untuk mendukung foto dari galeri
  String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.localImageFile,
    required this.description,
  });
}

class CartItem {
  Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

// Global list yang bisa ditambah, di-edit, atau dihapus secara dinamis
List<Product> sampleProducts = [
  Product(
    id: '1',
    name: 'Wardah Lipstick',
    price: 55000,
    imageUrl: 'assets/images/Wardah_Lipstick.jpg',
    description: 'Lipstik matte tahan lama',
  ),
  Product(
    id: '2',
    name: 'Timephoria',
    price: 129000,
    imageUrl: 'assets/images/Timephoria.jpg',
    description: 'Tinted lip gloss eksklusif',
  ),
  Product(
    id: '3',
    name: 'Love Puff',
    price: 20000,
    imageUrl: 'assets/images/Love_Puff.jpg',
    description: 'Puff makeup bentuk hati',
  ),
  Product(
    id: '4',
    name: 'Y2K Clip',
    price: 18000,
    imageUrl: 'assets/images/Y2K_Clip.jpg',
    description: 'Aksesoris jepit rambut gaya Y2K',
  ),
];

// Global Cart List
List<CartItem> cartItems = [];