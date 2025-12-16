import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import thư viện lưu trữ
import '../models/FoodModel.dart';
import '../models/CartModel.dart';
import '../utils/app_constants.dart';

class CartController extends GetxController {
  // Thay vì dùng Repo, ta dùng trực tiếp SharedPreferences
  final SharedPreferences sharedPreferences;

  CartController({required this.sharedPreferences});

  final Map<int, CartModel> _items = {};

  // ===> CÁC GETTER GIỮ NGUYÊN <===
  List<CartModel> get cartItems => _items.entries.map((e) => e.value).toList();

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) => totalQuantity += value.quantity!);
    return totalQuantity;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) => total += value.price! * value.quantity!);
    return total;
  }

  // ===> HÀM THÊM GIỎ HÀNG (GIỮ NGUYÊN LOGIC, CHỈ SỬA ĐOẠN CUỐI) <===
  void addItem(FoodModel product, {int quantity = 1}) {
    DateTime now = DateTime.now();
    String formattedTime = "${now.hour}:${now.minute} ${now.day}/${now.month}/${now.year}";
    
    // ... (Giữ nguyên logic if/else kiểm tra tồn tại và update số lượng như cũ) ...
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingCartItem) {
        return CartModel(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          img: existingCartItem.img,
          quantity: existingCartItem.quantity! + quantity,
          isExist: true,
          time: formattedTime,
          product: product,
        );
      });
      if (_items[product.id]!.quantity! <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.image,
            quantity: quantity,
            isExist: true,
            time: formattedTime,
            product: product,
          );
        });
      } else {
        Get.snackbar("Lỗi", "Bạn phải thêm ít nhất 1 sản phẩm");
      }
    }

    // ===> THAY ĐỔI: TỰ LƯU LUÔN TẠI ĐÂY <===
    cartListToStorage(cartItems);
    update();
  }

  // ===> CÁC HÀM XỬ LÝ LƯU TRỮ (MỚI THÊM VÀO) <===

  // 1. Hàm lưu danh sách giỏ hàng vào máy
  void cartListToStorage(List<CartModel> cartList) {
    List<String> cartStringList = [];
    var time = DateTime.now().toString();

    for (var element in cartList) {
      element.time = time;
      cartStringList.add(jsonEncode(element));
    }

    sharedPreferences.setStringList(AppConstants.CART_LIST, cartStringList);
  }

  // 2. Hàm lấy lịch sử (Dùng cho trang History)
  List<CartModel> getCartHistoryList() {
    List<String> cartHistoryString = [];
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistoryString = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    for (var element in cartHistoryString) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  // 3. Hàm lưu vào lịch sử (Gọi khi Check Out)
  void addToHistory() {
    List<String> cartHistoryString = [];
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistoryString = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    
    // Lấy giỏ hàng hiện tại chuyển sang String rồi thêm vào lịch sử
    for (int i = 0; i < cartItems.length; i++) {
      cartHistoryString.add(jsonEncode(cartItems[i]));
    }
    
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistoryString);
    clear();
  }

  // 4. Hàm xóa giỏ hàng
  void clear() {
    _items.clear();
    sharedPreferences.remove(AppConstants.CART_LIST); // Xóa trong máy luôn
    update();
  }
  
  // Các hàm phụ trợ khác (existInCart, getQuantity...) giữ nguyên
  bool existInCart(FoodModel product) {
    if (_items.containsKey(product.id)) return true;
    return false;
  }

  int getQuantity(FoodModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) quantity = value.quantity!;
      });
    }
    return quantity;
  }

  void removeItem(FoodModel foodModel) {}
}