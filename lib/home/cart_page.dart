import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../../widgets/app_icon.dart';
import '../home/cart_controller.dart';
import 'order_tracking_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      body: Stack(
        children: [
          // --- HEADER: Back, Home, Cart ---
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: 24,
                  ),
                ),
                SizedBox(width: 100),
                GestureDetector(
                  onTap: () {
                    Get.until((route) => route.isFirst);
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: 24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: 24,
                ),
              ],
            ),
          ),

          // --- BODY: Danh sách món ăn trong giỏ ---
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            bottom: 0,
            child: GetBuilder<CartController>(
              builder: (_) {
                return cartController.cartItems.isEmpty
                    ? Center(
                        child: BigText(
                          text: "Giỏ hàng trống!",
                          color: Colors.grey,
                          size: 22,
                        ),
                      )
                    : MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          itemCount: cartController.cartItems.length,
                          itemBuilder: (_, index) {
                            final food = cartController.cartItems[index];

                            return Container(
                              height: 100,
                              width: double.maxFinite,
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Row(
                                children: [
                                  // Hình món ăn
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/images/food_placeholder.png'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),

                                  // Thông tin món ăn
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                          text: food.name ?? '',
                                          color: Colors.black54,
                                        ),
                                        SmallText(text: "Món ăn"),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text: "${food.price}đ",
                                              color: Colors.redAccent,
                                            ),

                                            // Nút tăng giảm số lượng (tạm thời fix 1)
                                            // ===> CODE MỚI ĐÃ CÓ LOGIC TĂNG GIẢM <===
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  // 1. Nút GIẢM (-)
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Gọi hàm giảm số lượng từ Controller
                                                      // Lưu ý: food.product! là lấy đối tượng FoodModel từ CartModel
                                                      cartController.removeItem(food.product!);
                                                    },
                                                    child: const Icon(Icons.remove, color: AppColors.signColor),
                                                  ),
                                                  const SizedBox(width: 5),

                                                  // 2. HIỂN THỊ SỐ LƯỢNG THỰC TẾ
                                                  // Thay text: "1" bằng biến food.quantity.toString()
                                                  BigText(text: food.quantity.toString()), 

                                                  const SizedBox(width: 5),

                                                  // 3. Nút TĂNG (+)
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Gọi hàm thêm (mặc định thêm 1)
                                                      cartController.addItem(food.product!);
                                                    },
                                                    child: const Icon(Icons.add, color: AppColors.signColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          ),
        ],
      ),

      // --- BOTTOM: Tổng tiền + nút Check Out ---
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (_) {
          double total = 0;
          for (var food in cartController.cartItems) {
            total += food.price ?? 0;
          }

          return cartController.cartItems.isEmpty
              ? SizedBox.shrink()
              : Container(
                  height: 120,
                  padding:
                      EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tổng tiền
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            BigText(text: "${total.toStringAsFixed(1)}đ"),
                          ],
                        ),
                      ),

                      // Nút Check Out
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            print("Order Placed!");
                            Get.to(() => OrderTrackingPage());
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.mainColor,
                            ),
                            child: BigText(
                              text: "Check Out",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
