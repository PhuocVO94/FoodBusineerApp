import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/FoodModel.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final Map<int, CartModel> _items = {};

  // 1. Lấy danh sách item để hiển thị trong CartPage (chuyển từ Map sang List)
  List<CartModel> get cartItems {
    return _items.entries.map((e) => e.value).toList();
  }

  // 2. Lấy tổng số lượng item (dùng cho badge trên icon giỏ hàng)
  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  // 3. Lấy tổng tiền (dùng cho BottomBar trang CartPage)
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price! * value.quantity!;
    });
    return total;
  }

  // Hàm thêm vào giỏ hàng
  void addItem(FoodModel product, {int quantity = 1}) {
    // Nếu trong giỏ đã có món này rồi - Cập nhật số lượng
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (existingCartItem) {
        return CartModel(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          img: existingCartItem.img,
          quantity: existingCartItem.quantity! + quantity, // Cộng dồn số lượng
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      update(); 
      
    } else {
      _items.putIfAbsent(product.id!, () {
        return CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.image,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      update(); 
    }
  }

  // Hàm kiểm tra món ăn đã có trong giỏ chưa
  bool existInCart(FoodModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  // Hàm lấy số lượng của 1 món cụ thể 
  int getQuantity(FoodModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  // Hàm xóa hoặc giảm số lượng món ăn 
  void removeItem(FoodModel product) {
    if (_items.containsKey(product.id)) {
        _items.update(product.id!, (existingCartItem) {
          return CartModel(
            id: existingCartItem.id,
            name: existingCartItem.name,
            price: existingCartItem.price,
            img: existingCartItem.img,
            quantity: existingCartItem.quantity! - 1,
            isExist: true,
            time: existingCartItem.time,
            product: product
          );
        });
        
        // Nếu số lượng giảm về 0 hoặc dưới 0 thì xóa luôn khỏi map
        if(_items[product.id]!.quantity! <= 0){
          _items.remove(product.id);
        }
    }
    update();
  }
}

class CartModel {
  int? id;
  String? name;
  double? price; // Lưu ý kiểu dữ liệu (int hay double tùy)
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  FoodModel? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });

  // Hàm chuyển từ Json (nếu cần sau này lưu local storage)
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString()); // Ép kiểu an toàn
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = null;
  }
}