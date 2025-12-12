import 'package:food_delivery_app/data/repostitory/popular_product_repo.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
   int _Quantity =0;
  get Quantity =>_Quantity;

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList  => _popularProductList;
  bool _isLoad = false;
  bool get isLoad => _isLoad;
  Future<void> getPopularProductList() async {

     Response response = await popularProductRepo.getPopularProductList();
     if(response.statusCode == 200){
       _popularProductList = [];
       _popularProductList.addAll(Product.fromJson(response.body).products as Iterable );
        _isLoad = true;

       update();
     }else{

     }
  }
  void setQuantity(bool  iCheck){
    if(iCheck){
      _Quantity = checkQuantity(_Quantity +1);
    }else {
      _Quantity =checkQuantity(_Quantity -1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if(quantity <0) {
      quantity = 0;
      return quantity;
    } else if(quantity > 10) {
      quantity = 10;
      return quantity;
    } else {
      return quantity;
    }
  }

  void getDataProduct() {
    _Quantity = 0;
  }
}