import 'dart:io';
import 'package:flutter/foundation.dart';

class AppConstants {
  // BASE_URL tự động chọn theo nền tảng
  static String get baseUrl {
    if (kIsWeb) {
      // Flutter Web có thể dùng localhost
      return "http://localhost:8000";
    } else if (Platform.isAndroid) {
      // Android Emulator dùng 10.0.2.2 để trỏ về localhost của máy tính
      return "http://10.0.2.2:8000";
    } else if (Platform.isIOS) {
      // iOS Simulator có thể dùng localhost
      return "http://localhost:8000";
    } else {
      // Thiết bị thật (Android/iOS) → dùng IP LAN của máy tính
      return "http://192.168.1.5:8000"; // thay bằng IP LAN của mình
    }
  }

  static const String REGISTER_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";

  static const String REGISTRATION_URI="/api/v1/auth/registrater";


  static const String PRODUCT_URI = "/api/v1/products";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";

  static const String CART_URI = "/api/v1/cart";

  static const String ORDER_URI = "/api/v1/order";

  static const String TOKEN = "token";
  static const String USER_INFO = "user_info";
  static const String CART_LIST = "cart_list";
  static const String ORDER_HISTORY = "order_history";
}
