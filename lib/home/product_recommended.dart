import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/utils/app_column.dart';
import 'package:food_delivery_app/utils/app_column_forrecomeded.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/home/cart_controller.dart';
import 'package:food_delivery_app/home/cart_page.dart';
import 'package:food_delivery_app/utils/colors.dart';

import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:food_delivery_app/models/FoodModel.dart';




// ===> TRANG CHI TIẾT MÓN ĂN (ĐÃ CHUYỂN SANG STATEFUL ĐỂ ĐÁNH GIÁ) <===
class FoodDetailPage extends StatefulWidget {
  final ProductsModel? productModel;

  final FoodModel food;

  const FoodDetailPage({Key? key, required this.food, this.productModel,
    // required this.productModel
  }) : super(key: key);

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  // Biến dùng để xử lý Logic
  final CartController cartController = Get.find<CartController>();


  @override
  Widget build(BuildContext context) {
    // print('Test Food'+ food.userComments.toString());
    Get.find<PopularProductController>().getDataProduct();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- 1. ẢNH NỀN ---
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.viewPage,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.food.image), // Dùng widget.food
                ),
              ),
            ),
          ),
          
          // --- 2. ICON TOP ---
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                GetBuilder<CartController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 1) {
                        Get.to(() => const CartPage());
                      } else {
                        Get.snackbar("Thông báo", "Giỏ hàng trống!",
                            backgroundColor: AppColors.mainColor, 
                            colorText: Colors.white);
                      }
                    },
                    child: Stack(
                      children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0, top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      color: AppColors.mainColor, 
                                      shape: BoxShape.circle),
                                  child: Text(
                                    controller.totalItems.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // --- 3. NỘI DUNG CHI TIẾT ---
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.viewPage -20,
            child:

                Container(
                  padding:  EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                  decoration:  BoxDecoration(
                    borderRadius:BorderRadius.only(
                      topRight: Radius.circular(Dimensions.width20),
                      topLeft: Radius.circular(Dimensions.width20)

                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumnRecomended(food: widget.food),
                      SizedBox(height: Dimensions.height20),

                        // padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
                        const BigText(text: "Giới thiệu"),
                      SizedBox(height: Dimensions.height10),
                      Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: widget.food.description,) ,))
                     ,
                    ],
                  )



                ),


            ),
            // SizedBox(height: Dimensions.height20),

        ],
      ),

      // --- 4. BOTTOM BAR (Mua ngay & Thêm giỏ) ---
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: Dimensions.height120,
          padding:  EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height20, left: Dimensions.width15, right: Dimensions.width15),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius30),
              topRight: Radius.circular(Dimensions.radius30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:  EdgeInsets.all(Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.white,
                ),
               child: Row(
                 children: [
                   GestureDetector(
                       onTap: () {
                         popularProduct.setQuantity(false);
                       },

                       child: Icon(Icons.remove, color: AppColors.signColor,)),
                   SizedBox(width: Dimensions.width10 /2,),
                   BigText(text: popularProduct.Quantity.toString()),
                   SizedBox(width: Dimensions.width10 /2,),
                   GestureDetector(

                       onTap: () {
                         popularProduct.setQuantity(true);
                       },
                       child: Icon(Icons.add, color: AppColors.signColor,)),

                 ],
               ),
              ),
              GestureDetector(
                onTap: () {

                  Get.to(() => const CartPage());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                  child: BigText(
                    text: "Mua ngay | ${widget.food.price.toInt()}đ",
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),

            ],
          ),
        );
      }),
    );
  }
}

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.size = 40,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Icon(icon, color: iconColor, size: 16),
    );
  }
}