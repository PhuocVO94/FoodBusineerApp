import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/home/foodpagebody.dart';
import 'package:food_delivery_app/home/cart_controller.dart';
import 'package:food_delivery_app/home/profile.dart';
import 'package:food_delivery_app/home/history.dart';
import 'package:food_delivery_app/home/cart_page.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:food_delivery_app/models/FoodModel.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);
  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  int _selectedIndex = 0;
  List<Widget> get _pages => const [
        FoodPageBody(),
        History(),
        CartPage(),
        Profile(),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const BigText(text: "Việt Nam", color: AppColors.mainColor),
                    Row(
                      children: const [
                        SmallText(text: "Hồ Chí Minh", color: Colors.black54),
                        Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.mainColor,
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: IndexedStack(index: _selectedIndex, children: _pages)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 5),
        SmallText(text: text, color: AppColors.paraColor),
      ],
    );
  }
}

class FoodDetailPage extends StatefulWidget {
  final FoodModel food;
  const FoodDetailPage({Key? key, required this.food}) : super(key: key);

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  final CartController cartController = Get.find<CartController>();
  
  int _userRating = 5; // Mặc định 5 sao
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print('Test Food'+ food.userComments.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ẢNH NỀN 
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.food.image), 
                ),
              ),
            ),
          ),
          
          // ICON TOP 
          Positioned(
            top: 45,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const AppIcon(icon: Icons.arrow_back_ios, iconSize: 30,),
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
                        const AppIcon(icon: Icons.shopping_cart_outlined, iconSize: 30,),
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

          // NỘI DUNG CHI TIẾT
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 330,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Tên và Giá
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: BigText(text: widget.food.name, size: 26)),
                      BigText(
                        text: "${widget.food.price.toInt()}đ",
                        color: AppColors.mainColor,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  // Hiển thị đánh giá trung bình (Read-only)
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(5, (index) => const Icon(Icons.star, color: AppColors.mainColor, size: 15)),
                      ),
                      const SizedBox(width: 10),
                      SmallText(text: "${widget.food.rating}"),
                      const SizedBox(width: 10),
                      SmallText(text: "${widget.food.commentsCount} đánh giá"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Icon thông tin
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const IconAndTextWidget(icon: Icons.circle_sharp, text: "Ngon", iconColor: AppColors.iconColor1),
                      IconAndTextWidget(icon: Icons.location_on, text: widget.food.location, iconColor: AppColors.mainColor),
                      IconAndTextWidget(icon: Icons.access_time_rounded, text: widget.food.time, iconColor: AppColors.iconColor2),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // VIẾT ĐÁNH GIÁ 
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[100], // Màu nền nhẹ cho khung đánh giá
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BigText(text: "Đánh giá của bạn", size: 18),
                        const SizedBox(height: 10),
                        
                        // Hàng sao tương tác (Bấm để chọn)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              onPressed: () {
                                setState(() {
                                  _userRating = index + 1;
                                });
                              },
                              icon: Icon(
                                index < _userRating ? Icons.star : Icons.star_border,
                                color: Colors.orange,
                                size: 30,
                              ),
                            );
                          }),
                        ),

                        // Ô nhập bình luận
                        TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: "Viết cảm nhận của bạn...",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(15),
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 10),

                        // 3. Nút Gửi
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Xử lý gửi đánh giá
                              if (_commentController.text.isEmpty) {
                                Get.snackbar("Lỗi", "Vui lòng nhập nội dung!", backgroundColor: Colors.redAccent, colorText: Colors.white);
                              } else {
                                Get.snackbar(
                                  "Thành công", 
                                  "Đã gửi đánh giá $_userRating sao!",
                                  backgroundColor: Colors.green, 
                                  colorText: Colors.white
                                );
                                // Reset sau khi gửi
                                setState(() {
                                  _commentController.clear();
                                  _userRating = 5;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mainColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("Gửi", style: TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const BigText(text: "Giới thiệu"),
                  const SizedBox(height: 10),
                  SmallText(
                    text: widget.food.description,
                    size: 16,
                    color: AppColors.paraColor,
                    height: 1.5,
                  ),
                  const SizedBox(height: 120), 
                ],
              ),
            ),
          ),
        ],
      ),

      // BOTTOM BAR (Mua ngay - Thêm giỏ)
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
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.mainColor, 
                ),
                child: const Icon(Icons.favorite, color: Colors.white),
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
                      margin: const EdgeInsets.only(right: 15), 
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green, 
                      ),
                      child: BigText(
                        text: "Mua ngay | ${widget.food.price.toInt()}đ",
                        color: Colors.white,
                        size: 18,
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
    this.size = 40, required int iconSize,
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