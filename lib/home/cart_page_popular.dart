import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/CartModel.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../../widgets/app_icon.dart';
import 'cart_controller.dart';
import '../home/order_tracking_page.dart';
import 'history_controller.dart';

class CartPagePopular extends StatelessWidget {

  final ProductsModel productsModel;
  const CartPagePopular({Key? key, required this.productsModel, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    print('Phuoc Check'+ productsModel.name.toString());
    // Đảm bảo HistoryController đã được khởi tạo
    if (!Get.isRegistered<HistoryController>()) {
      Get.put(HistoryController());
    }

    return Scaffold(
      body: Stack(
        children: [
          // --- HEADER: Nút Back, Home, Cart Icon ---
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.icon24,
                  ),
                ),
                SizedBox(width: Dimensions.listViewTextContSize),
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed("/");
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.icon24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.icon24,
                ),
              ],
            ),
          ),

          // --- BODY: Danh sách món ăn trong giỏ ---
          Positioned(
            top: Dimensions.height120,
            left: 0,
            right: 0,
            bottom: 0,
            child: GetBuilder<CartController>(
              builder: (_) {
                return cartController.cartItems.isEmpty
                    ? Center(
                  child: BigText(
                    text: "Giỏ hàng của bạn đang trống!",
                    color: Colors.grey,
                    size: Dimensions.font20,
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
                        height: Dimensions.listViewTextContSize,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            // Ảnh món ăn
                            Container(
                              width: Dimensions.listViewTextContSize,
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/images/food_placeholder.png'),
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.width10),

                            // Thông tin món ăn
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Tên món
                                  BigText(
                                      text: food.name ?? '',
                                      color: Colors.black54,
                                      size: Dimensions.font20),

                                  // ===> HIỂN THỊ THỜI GIAN THÊM VÀO GIỎ <===
                                  // Thay thế dòng "Ngon, hấp dẫn" bằng thời gian
                                  SmallText(
                                    text: "Đã thêm lúc: ${food.time ?? 'Vừa xong'}",
                                    color: Colors.grey,
                                  ),

                                  // Giá tiền và nút tăng giảm
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                          text: "${food.price}đ",
                                          color: Colors.redAccent,
                                          size: Dimensions.font20),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Dimensions.height10,
                                            horizontal: Dimensions.width10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () => cartController.removeItem(food.product!),
                                              child: Icon(Icons.remove,
                                                  color: AppColors.signColor,
                                                  size: Dimensions.icon24),
                                            ),
                                            SizedBox(width: Dimensions.width5),
                                            BigText(
                                                text: food.quantity.toString(),
                                                size: Dimensions.font20),
                                            SizedBox(width: Dimensions.width5),
                                            GestureDetector(
                                              onTap: () => cartController.addItem(food.product!),
                                              child: Icon(Icons.add,
                                                  color: AppColors.signColor,
                                                  size: Dimensions.icon24),
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

      // --- BOTTOM: Tổng tiền + Nút Check Out ---
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (_) {
          double total = 0;
          for (var item in cartController.cartItems) {
            total += (item.price! * item.quantity!);
          }

          return cartController.cartItems.isEmpty
              ? SizedBox.shrink()
              : Container(
            height: Dimensions.height120,
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.height30,
                horizontal: Dimensions.width20),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tổng tiền
                Container(
                  padding: EdgeInsets.all(Dimensions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: BigText(
                      text: "${total.toStringAsFixed(0)}đ",
                      size: Dimensions.font20),
                ),

                // Nút Check Out
                GestureDetector(
                  onTap: () {
                    // Lấy thời gian thực khi bấm Checkout
                    DateTime now = DateTime.now();
                    String formattedTime =
                        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} "
                        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";

                    // Lưu vào lịch sử
                    if (Get.isRegistered<HistoryController>()) {
                      Get.find<HistoryController>().addOrder(
                          cartController.cartItems,
                          orderTime: formattedTime);
                    }

                    // Xóa giỏ hàng
                    cartController.clear();

                    // Thông báo
                    Get.snackbar("Thành công", "Đã đặt hàng lúc $formattedTime", backgroundColor: AppColors.mainColor, colorText: Colors.white);

                    // Chuyển trang
                    Get.to(() => OrderTrackingPage(orderTime: formattedTime));
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.height20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                        text: "Check Out",
                        color: Colors.white,
                        size: Dimensions.font20),
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