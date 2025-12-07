import 'package:food_delivery_app/apiService/apiclient.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/data/repostitory/popular_product_repo.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  
  Get.lazyPut(() =>ApiClient(appBaseUrl:AppConstants.BASE_URL));
  Get.lazyPut(()=>PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=>PopularProductController(popularProductRepo: Get.find()));
}