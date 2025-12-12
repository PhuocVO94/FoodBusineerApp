

class CartModelPopular {
  int? id;
  String? name;
  int? price; // Lưu ý kiểu dữ liệu (int hay double tùy logic của bạn)
  String? img;
  int? quantity;
  bool? isExist;
  String? time;


  CartModelPopular({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExist,
    this.time,

  });


  CartModelPopular.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist =json['isExist'];
    time = json['time'];

  }
}