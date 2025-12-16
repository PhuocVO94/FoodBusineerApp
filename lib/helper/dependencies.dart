import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/respository/auth_repo.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
Future<void> init()async {
  final sharedPreferences = await SharedPreferences.getInstance();
  
  Get.lazyPut(() => sharedPreferences);
  //api client 
  Get.lazyPut(() =>ApiClient(appBaseUrl: AppConstants.baseUrl));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
}
