// import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import 'package:food_delivery_app/apiService/apiclient.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommenedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommenedProductRepo({ required this.apiClient});


  Future<Response> getRecommendedProductList() async {

    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);

  }


}
