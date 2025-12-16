import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/repostitory/popular_product_repo.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';
// ===> ĐẢM BẢO IMPORT ĐÚNG FILE MODEL CỦA BẠN <===
import 'package:food_delivery_app/models/FoodModel.dart'; 
import '../home/cart_controller.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  int _Quantity = 0;
  int _totalItemsNew = 0;
  get Quantity => _Quantity;
  get totalItems =>  _totalItemsNew;

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoad = false;
  bool get isLoad => _isLoad;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      // Lưu ý: Đảm bảo Product.fromJson trả về đúng kiểu dữ liệu tương thích
      _popularProductList.addAll(Product.fromJson(response.body).products as Iterable);
      _isLoad = true;
      update();
    } else {}
  }

  void setQuantity(bool iCheck) {
    if (iCheck) {
      _Quantity = checkQuantity(_Quantity + 1);
    } else {
      _Quantity = checkQuantity(_Quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      quantity = 0;
      Get.snackbar("Thông báo", "Giỏ hàng đang trống",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return quantity;
    } else if (quantity > 10) {
      Get.snackbar("Thông báo", "Giỏ hàng đã đầy",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      quantity = 10;
      return quantity;
    } else {
      return quantity;
    }
  }

  // --- PHẦN CODE ĐÃ SỬA LẠI (THAY ProductModel -> FoodModel) ---

  late CartController _cart;
  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _Quantity;

  // 1. Sửa tham số thành FoodModel để khớp với CartController
  void initProduct(FoodModel product, CartController cart) {
    _Quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    // Không update() ở đây
  }

  // 2. Sửa tham số thành FoodModel
  void addItem(FoodModel product) {
    if (_Quantity > 0) {
      _cart.addItem(product, quantity: _Quantity);
      _Quantity = 0;
      _inCartItems = _cart.getQuantity(product);

      Get.snackbar("Thành công", "Đã thêm vào giỏ hàng",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    } else {
      Get.snackbar("Lỗi", "Bạn chưa chọn số lượng!",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
    update();
  }

  void getDataProduct() {
    _Quantity = 0;
  }
}