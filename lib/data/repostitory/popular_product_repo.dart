// import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import 'package:food_delivery_app/apiService/apiclient.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({ required this.apiClient});


  Future<Response> getPopularProductList() async {

    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);

  }


}
