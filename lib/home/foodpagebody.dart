import 'package:flutter/material.dart';
import 'package:food_delivery_app/home/product_detail.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/utils/app_column.dart';
import 'package:food_delivery_app/utils/app_column_forrecomeded.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
// import 'package:food_delivery_app/home/main_food_page.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';
// CÁC DÒNG IMPORT QUAN TRỌNG - ĐÃ CHỈNH KHỚP VỚI ẢNH CỦA BẠN
import '../controller/popular_product_controller.dart';
import '../utils/colors.dart';
import '../widgets/big_text.dart';

import '../widgets/small_text.dart';
import '../models/FoodModel.dart'; // Import file model.dart bạn vừa sửa
import 'product_recommended.dart'; // Import trang chi tiết bạn vừa tạo cùng thư mục


class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = 220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
        children: [
          // --- SLIDER (PAGEVIEW) ---
          SizedBox(
            height: Dimensions.viewPage,
            child: PageView.builder(
              controller: pageController,
              itemCount: vietnameseFoods.length > 5 ? 5 : vietnameseFoods.length,
              itemBuilder: (context, position) {
                return _buildPageItem(position, vietnameseFoods[position]);
              },
            ),
          ),

          // --- DOTS INDICATOR ---



          DotsIndicator(pageValue: _currPageValue),

          // --- TIÊU ĐỀ DANH SÁCH ---
          SizedBox(height: Dimensions.height30),
          Container(
            margin: EdgeInsets.only(left: Dimensions.width10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: "Italian"),
                SizedBox(width: Dimensions.width10),
                Container(margin: EdgeInsets.only(bottom: 3), child: BigText(text: ".", color: Colors.black26)),
                SizedBox(width: Dimensions.width10),
                Container(margin: EdgeInsets.only(bottom: 2), child: SmallText(text: "Hương vị quê hương")),
              ],
            ),
          ),

          // --- DANH SÁCH MÓN ĂN (LIST VIEW) ---

          GetBuilder<PopularProductController>(builder:(popularProduct){

            return popularProduct.isLoad? ListView.builder(
              physics:NeverScrollableScrollPhysics() ,
              shrinkWrap: true,
              itemCount: vietnameseFoods.length,
              itemBuilder: (context, index) {
                ProductsModel productsModel = popularProduct.popularProductList[index];

                FoodModel food = vietnameseFoods[index]; // Lấy dữ liệu món ăn

                return GestureDetector(
                  // SỰ KIỆN BẤM VÀO MÓN ĂN
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailPage(food: food)));
                    Get.to(()=>ProductDetailPage(product: productsModel));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.top10),
                    child: Row(
                      children: [
                        // Hình ảnh
                        Container(
                          width: Dimensions.viewPicture,
                          height: Dimensions.viewPicture,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.height30),
                            color: Colors.white38,
                            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage("${AppConstants.BASE_URL}/uploads/${productsModel.img!}")),
                          ),
                        ),
                        // Thông tin chi tiết
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextContSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.width20), bottomRight: Radius.circular(Dimensions.width20)),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Color(0xFFe8e8e8), blurRadius: 5.0, offset: Offset(0, 5))],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                              child: AppColumn(food: food,productsModel: productsModel,  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ):CircularProgressIndicator(
              color: AppColors.mainColor,
            ) ;
          }),

        ],
      ),
      )
    );
  }


  // Scalle Page ITem
  Widget _buildPageItem(int index, FoodModel food,) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale = _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailPage(food: food)));
        },
        child: Stack(
          children: [
            Container(
              height: Dimensions.viewPageContainer,
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.width30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(food.image)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.viewPageTextContainer,
                margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.width30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Color(0xFFe8e8e8), blurRadius: 5.0, offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.top15, left: Dimensions.width15, right: Dimensions.width15),
                  child: AppColumnRecomended(food: food),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// Helper widget cho Dots Indicator
class DotsIndicator extends StatelessWidget {
  final double pageValue;
  const DotsIndicator({super.key, required this.pageValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          width: pageValue.round() == index ? 10 : 8,
          height: pageValue.round() == index ? 10 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: pageValue.round() == index ? AppColors.mainColor : Colors.grey,
          ),
        );
      }),
    );
  }
}