import 'package:food_delivery_app/data/repostitory/cart_product_repo.dart';
import 'package:food_delivery_app/models/CartModel.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';

class CartControllorPopular extends GetxController {

  final CartRepo cartRepo;
  CartControllorPopular({required this.cartRepo});

Map<int, CartModelPopular> _item = {};


  addItemCart(ProductsModel product, int _quantity) {

    _item.putIfAbsent(product.id!, () => CartModelPopular(
      id:  product.id,
      name:  product.name,
      price:  product.price,
      img:  product.img,
      quantity:  _quantity,
      isExist:  true,
      time:  DateTime.now().toString(),
    ));
  }



}