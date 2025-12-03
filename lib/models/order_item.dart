import '../home/cart_page.dart';

class OrderItem {
  final String orderId;
  final List<CartItem> items;
  final String restaurant;
  final DateTime dateTime;
  final String paymentMethod;
  final String deliveryStatus;
  final int total;

  OrderItem({
    required this.orderId,
    required this.items,
    required this.restaurant,
    required this.dateTime,
    required this.paymentMethod,
    required this.deliveryStatus,
    required this.total,
  });

  String get imageUrl => items.isNotEmpty ? items.first.image : '';
  String get foodName => items.isNotEmpty ? items.first.name : '';
}

class CartItem {
  final String name;
  final int quantity;
  final int price;
  final String image;

  CartItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });
}