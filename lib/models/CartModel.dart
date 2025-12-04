import 'FoodModel.dart';

class CartModel {
  int? id;
  String? name;
  double? price; // Lưu ý kiểu dữ liệu (int hay double tùy logic của bạn)
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
}