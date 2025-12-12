import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/history_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
// Import file chứa CartModel (thường là cart_controller.dart hoặc file model riêng)
import 'cart_controller.dart';
// Import trang OrderTrackingPage để chuyển hướng
import 'order_tracking_page.dart'; 

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Đảm bảo controller đã được khởi tạo
    bool isRegistered = Get.isRegistered<HistoryController>();
    if (!isRegistered) {
      Get.put(HistoryController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      // Thanh tiêu đề
      appBar: AppBar(
        title: BigText(text: "Lịch sử đơn hàng", color: Colors.white, size: Dimensions.font20),
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false, // Tắt nút back mặc định
        actions: [
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: Dimensions.width20),
        ],
      ),
      
      // Nội dung danh sách
      body: GetBuilder<HistoryController>(
        builder: (controller) {
          var historyList = controller.historyList;

          // 1. Nếu chưa có đơn hàng nào
          if (historyList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_toggle_off, size: Dimensions.height120, color: Colors.grey[300]),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Bạn chưa có đơn hàng nào!", color: Colors.grey),
                ],
              ),
            );
          }

          // 2. Hiển thị danh sách đơn hàng
          return ListView.builder(
            padding: EdgeInsets.only(top: Dimensions.height10),
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              // Lấy dữ liệu từng đơn hàng
              var order = historyList[index];
              var orderTime = order['time'];
              var orderTotal = order['total'];
              var orderStatus = order['status'];
              List<CartModel> orderItems = order['items'];
              var firstItem = orderItems[0];

              // ===> BỌC GESTURE DETECTOR ĐỂ BẮT SỰ KIỆN CLICK <===
              return GestureDetector(
                onTap: () {
                  // Chuyển sang trang Order Tracking khi bấm vào đơn hàng
                  Get.to(() => OrderTrackingPage(orderTime: orderTime));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.width20, 
                    right: Dimensions.width20, 
                    bottom: Dimensions.height10
                  ),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.height10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        )
                      ]
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- CỘT 1: HÌNH ẢNH ---
                        Container(
                          height: Dimensions.height20 * 4,
                          width: Dimensions.height20 * 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
                            color: Colors.grey[200],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/food_placeholder.png"), 
                            )
                          ),
                        ),
                        SizedBox(width: Dimensions.width10),

                        // --- CỘT 2: THÔNG TIN CHI TIẾT ---
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Tên món
                              BigText(
                                text: orderItems.length > 1 
                                  ? "${firstItem.name} và ${orderItems.length - 1} món khác"
                                  : "${firstItem.name}",
                                size: Dimensions.font16,
                                color: Colors.black87,
                              ),
                              SizedBox(height: Dimensions.height10),
                              
                              // Thời gian
                              SmallText(text: "Thời gian: $orderTime", color: Colors.grey),
                              SizedBox(height: Dimensions.height10),

                              // Trạng thái và Giá tiền
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green[50],
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.green.withOpacity(0.5))
                                    ),
                                    child: SmallText(text: orderStatus, color: Colors.green),
                                  ),
                                  
                                  BigText(
                                    text: "${orderTotal.toStringAsFixed(0)}đ", 
                                    color: AppColors.mainColor, 
                                    size: Dimensions.font16
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}