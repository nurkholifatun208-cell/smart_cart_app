import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class Order {
  final String id;
  final List<CartItem> products;
  final double totalAmount;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.products,
    required this.totalAmount,
    required this.dateTime,
  });
}

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        products: cartProducts,
        totalAmount: total,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}