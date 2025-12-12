import 'FoodModel.dart';

class CartModel {
  int? id;
  String? name;
  double? price; // Lưu ý kiểu dữ liệu (int hay double tùy logic của bạn)
  String? img;
  int? quantity;
  bool? isExist;
  String? time;


  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExist,
    this.time,

  });


  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist =json['isExist'];
    time = json['time'];

  }
}