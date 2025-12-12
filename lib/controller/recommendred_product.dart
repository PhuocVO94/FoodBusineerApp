import 'package:food_delivery_app/data/repostitory/popular_product_repo.dart';
import 'package:food_delivery_app/data/repostitory/recommended_product_repo.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';

class RecommendProductController extends GetxController {
  final RecommenedProductRepo RecommendProductRepo;

  RecommendProductController({required this.RecommendProductRepo});
  List<dynamic> _RecommendProductList = [];
  List<dynamic> get RecommendProductList  => _RecommendProductList;
  bool _isLoad = false;
  bool get isLoad => _isLoad;
  Future<void> getRecommendedProductList() async {

    Response response = await RecommendProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      // print("Get Products");
      _RecommendProductList = [];
      _RecommendProductList.addAll(Product.fromJson(response.body).products as Iterable );
      _isLoad = true;

      update();
    }else{


    }
  }
}