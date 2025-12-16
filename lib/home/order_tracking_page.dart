import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
// QUAN TRỌNG: Import trang chủ để quay về
import 'main_food_page.dart'; 

class OrderTrackingPage extends StatelessWidget {
  final String? orderTime; 
  
  const OrderTrackingPage({super.key, this.orderTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: BigText(text: "Theo dõi đơn hàng", size: Dimensions.font24, color: Colors.white),
        backgroundColor: AppColors.mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: Dimensions.icon24),
          // Bấm nút Back trên thanh tiêu đề thì chỉ quay lại trang trước (Lịch sử hoặc Cart)
          onPressed: () => Get.back(), 
        ),
      ),
      body: Column(
        children: [
          // --- PHẦN BẢN ĐỒ ---
          Expanded(
            child: Container(
              width: double.maxFinite,
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: Dimensions.height45 * 2, color: AppColors.mainColor),
                    SizedBox(height: Dimensions.height10),
                    SmallText(text: "Bản đồ đang hiển thị...", size: Dimensions.font12),
                  ],
                ),
              ),
            ),
          ),

          // --- BOTTOM PANEL ---
          Container(
            height: Dimensions.height30 * 14,
            padding: EdgeInsets.all(Dimensions.height20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius30),
                topRight: Radius.circular(Dimensions.radius30),
              ),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Shipper
                Row(
                  children: [
                    CircleAvatar(
                      radius: Dimensions.radius20 * 1.5,
                      backgroundColor: AppColors.mainColor,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    SizedBox(width: Dimensions.width15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: "Nguyễn Văn A", size: Dimensions.font20),
                          SmallText(text: "Shipper - 4.8 ⭐"),
                        ],
                      ),
                    ),
                    Icon(Icons.phone, color: AppColors.mainColor, size: Dimensions.icon24 * 1.5)
                  ],
                ),
                SizedBox(height: Dimensions.height20),
                Divider(thickness: 1, color: Colors.grey[200]),
                
                // Timeline
                Expanded(child: Center(child: SmallText(text: "Trạng thái đơn hàng: Đang giao..."))),

                // --- CÁC NÚT THAO TÁC ---
                Row(
                  children: [
                    // ===> NÚT HỦY ĐƠN <===
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                            title: "Hủy Đơn Hàng?",
                            middleText: "Bạn có chắc chắn muốn hủy đơn hàng này không?",
                            textConfirm: "Đồng ý",
                            textCancel: "Đóng",
                            confirmTextColor: Colors.white,
                            buttonColor: AppColors.mainColor,
                            cancelTextColor: AppColors.mainColor,
                            onConfirm: () {
                              
                              // 2. Đóng hộp thoại Dialog trước
                              Get.back(); 
                              
                              // 3. Thông báo
                              Get.snackbar(
                                "Đã hủy", 
                                "Đơn hàng của bạn đã hủy thành công.",
                                backgroundColor: Colors.redAccent, 
                                colorText: Colors.white,
                                duration: Duration(seconds: 2)
                              );

                              // 4. QUAY VỀ TRANG CHỦ (MAIN FOOD PAGE)
                              // Lệnh này sẽ xóa hết các trang hiện tại và mở lại trang chủ mới tinh
                              Get.offAll(() => const MainFoodPage()); 
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(child: BigText(text: "Hủy đơn", color: Colors.black54, size: Dimensions.font16)),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.width20),
                    
                    // ===> NÚT VỀ TRANG CHỦ <===
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Quay về trang chủ
                          Get.offAll(() => const MainFoodPage());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(child: BigText(text: "Về Trang Chủ", color: Colors.white, size: Dimensions.font16)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}