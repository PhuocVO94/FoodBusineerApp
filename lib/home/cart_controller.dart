import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/FoodModel.dart'; // Đảm bảo import đúng model Food của bạn
// import '../utils/colors.dart'; // Mở nếu cần dùng màu sắc

class CartController extends GetxController {
  // Biến lưu trữ danh sách giỏ hàng: Key là ID món ăn, Value là CartModel
  final Map<int, CartModel> _items = {};

  // ===> GETTERS (Lấy dữ liệu ra UI) <===

  List<CartModel> get cartItems {
    return _items.entries.map((e) => e.value).toList();
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price! * value.quantity!;
    });
    return total;
  }

  // ===> CÁC HÀM XỬ LÝ LOGIC <===

  // Hàm thêm vào giỏ hàng (ĐÃ CẬP NHẬT THỜI GIAN THỰC)
  void addItem(FoodModel product, {int quantity = 1}) {
    // 1. Lấy thời gian hiện tại và định dạng chuỗi
    DateTime now = DateTime.now();
    String formattedTime = 
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} "
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";

    // 2. Kiểm tra và thêm vào giỏ
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (existingCartItem) {
        return CartModel(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          img: existingCartItem.img,
          quantity: existingCartItem.quantity! + quantity,
          isExist: true,
          time: formattedTime, // <--- Cập nhật thời gian thêm mới nhất
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
          img: product.image, // Lưu ý: kiểm tra trường image trong FoodModel của bạn (img hay image)
          quantity: quantity,
          isExist: true,
          time: formattedTime, // <--- Lưu thời gian lúc thêm mới
          product: product,
        );
      });
      update();
    }
  }

  bool existInCart(FoodModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

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
            time: existingCartItem.time, // Giữ nguyên thời gian cũ khi giảm số lượng
            product: product);
      });

      if (_items[product.id]!.quantity! <= 0) {
        _items.remove(product.id);
      }
    }
    update();
  }

  // Hàm xóa sạch giỏ hàng (Dùng khi Check Out xong)
  void clear() {
    _items.clear();
    update();
  }
}

// ===> CART MODEL <===
class CartModel {
  int? id;
  String? name;
  double? price;
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

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = null; // Cần logic riêng nếu muốn parse product từ json
  }
  
  // Hàm chuyển thành Json để lưu trữ (nếu cần)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "img": img,
      "quantity": quantity,
      "isExist": isExist,
      "time": time,
    };
  }
}