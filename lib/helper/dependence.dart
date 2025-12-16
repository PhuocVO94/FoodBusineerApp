import 'package:food_delivery_app/apiService/apiclient.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/controller/recommendred_product.dart';
import 'package:food_delivery_app/data/repostitory/popular_product_repo.dart';
import 'package:food_delivery_app/data/repostitory/recommended_product_repo.dart';
import 'package:food_delivery_app/home/cart_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences);

  // API Cilent
  Get.lazyPut(() =>ApiClient(appBaseUrl:AppConstants.BASE_URL));

  // Repo
  Get.lazyPut(()=>PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() =>RecommenedProductRepo(apiClient: Get.find()));




  // Controllor
  Get.lazyPut(()=>PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(()=>RecommendProductController(RecommendProductRepo: Get.find()));
  Get.lazyPut(() => CartController(sharedPreferences: Get.find()));
}