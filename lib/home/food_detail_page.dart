import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/app_column.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/home/cart_controller.dart';

import 'package:food_delivery_app/home/cart_page.dart';
import 'package:food_delivery_app/utils/colors.dart';

import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:food_delivery_app/models/FoodModel.dart';
import '../widgets/icon_and_text.dart';




// ===> TRANG CHI TIẾT MÓN ĂN (ĐÃ CHUYỂN SANG STATEFUL ĐỂ ĐÁNH GIÁ) <===
class FoodDetailPage extends StatefulWidget {
  final FoodModel food;
  const FoodDetailPage({Key? key, required this.food}) : super(key: key);

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  // Biến dùng để xử lý Logic
  final CartController cartController = Get.find<CartController>();


  @override
  Widget build(BuildContext context) {
    // print('Test Food'+ food.userComments.toString());
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
            child: Container(
              padding:  EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
              decoration:  BoxDecoration(
                borderRadius:BorderRadius.only(
                  topRight: Radius.circular(Dimensions.width20),
                  topLeft: Radius.circular(Dimensions.width20)

                ),
                color: Colors.white,
              ),
              child: AppColumn(food: widget.food,),
              // child: ListView(
              //   padding: EdgeInsets.zero,
              //   children: [
              //     // Tên và Giá
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Expanded(child: BigText(text: widget.food.name, size: Dimensions.icon24)),
              //         BigText(
              //           text: "${widget.food.price.toInt()}đ",
              //           color: AppColors.mainColor,
              //           size: Dimensions.font20,
              //         ),
              //       ],
              //     ),
              //      SizedBox(height: Dimensions.height10),
              //
              //     // Hiển thị đánh giá trung bình (Read-only)
              //     Row(
              //
              //       children: [
              //         Wrap(
              //           children: List.generate(5, (index) =>  Icon(Icons.star, color: AppColors.mainColor, size: Dimensions.font20)),
              //         ),
              //          SizedBox(width:Dimensions.width10 ),
              //         SmallText(text: "${widget.food.rating}"),
              //          SizedBox(width: Dimensions.width10),
              //         SmallText(text: "${widget.food.commentsCount} đánh giá"),
              //       ],
              //     ),
              //      SizedBox(height: Dimensions.height10),
              //
              //     // Icon thông tin
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         IconAndTextWidget(icon: Icons.circle_sharp, text: "Ngon", iconColor: AppColors.iconColor1, color: AppColors.textColor, iconSize: 27),
              //         IconAndTextWidget(icon: Icons.location_on, text: widget.food.location, iconColor: AppColors.iconColor1, color: AppColors.textColor, iconSize: 27),
              //         IconAndTextWidget(icon: Icons.access_time_rounded, text: widget.food.time, iconColor: AppColors.iconColor1, color: AppColors.textColor, iconSize: 27),
              //
              //       ],
              //     ),
              //     SizedBox(height: Dimensions.height20),
              //
              //
              //     SizedBox(height: Dimensions.height20),
              //     const BigText(text: "Giới thiệu"),
              //     SizedBox(height: Dimensions.height10),
              //     SmallText(
              //       text: widget.food.description,
              //       size: Dimensions.font16,
              //       color: AppColors.paraColor,
              //       height: 1.5,
              //     ),
              //
              //   ],
              // ),
            ),
          ),
        ],
      ),

      // --- 4. BOTTOM BAR (Mua ngay & Thêm giỏ) ---
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
        return Container(
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: const Icon(Icons.favorite, color: AppColors.mainColor),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.addItem(widget.food);
                      Get.snackbar("Thông báo", "Đã thêm vào giỏ hàng",
                          duration: const Duration(seconds: 1),
                          backgroundColor: AppColors.mainColor,
                          colorText: Colors.white);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.mainColor,
                      ),
                      child: const Icon(Icons.add_shopping_cart, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(widget.food);
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
              )
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