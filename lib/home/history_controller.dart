import 'package:get/get.dart';
import '../models/order_item.dart';
import '../models/FoodModel.dart';

class HistoryController extends GetxController {
  var orderHistory = <OrderItem>[].obs;

  void addOrder(OrderItem order) {
    orderHistory.add(order);
  }

  void clearHistory() {
    orderHistory.clear();
  }
}

