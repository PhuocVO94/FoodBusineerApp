import 'package:food_delivery_app/data/repostitory/cart_product_repo.dart';
import 'package:food_delivery_app/models/CartModel.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';

class CartControllorPopular extends GetxController {
  final CartRepo cartRepo;
  CartControllorPopular({required this.cartRepo});

  Map<int, CartModelPopular> _items = {};
  Map<int, CartModelPopular> get items => _items;

  void addItemCart(ProductsModel product, int quantity) {

    if (_items.containsKey(product.id)) {
      print("Check Product Name" + product.name.toString());
      _items.update(product.id!, (cartItem) {
        return CartModelPopular(
          id: cartItem.id,
          img: cartItem.img,
          name: cartItem.name,
          price: cartItem.price,
          quantity: cartItem.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      });
    } else {
      _items.putIfAbsent(product.id!, () {
        print("Check Product Name" + product.name.toString());
        return CartModelPopular(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      });
    }

    // print("Item count: ${}");
    update();   //  🔥🔥🔥 PHẢI CÓ
  }
}
