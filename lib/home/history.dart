import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:food_delivery_app/models/CartModel.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ==========================================================
    // 1. TẠO DỮ LIỆU GIẢ VỚI LINK ẢNH THẬT (ONLINE)
    // ==========================================================
    List<CartModel> getCartHistoryList = [
      // Đơn hàng 1: Pizza và Burger
      CartModel(
        name: "Spicy Pizza",
        price: 12.5,
        // Dùng link ảnh trực tiếp từ internet để hiển thị luôn
        img: "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        quantity: 1,
        time: "2025-12-15 10:30:00",
      ),
      CartModel(
        name: "Beef Burger",
        price: 8.0,
        img: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        quantity: 2,
        time: "2025-12-15 10:30:00",
      ),

      // Đơn hàng 2: Sushi
      CartModel(
        name: "Sushi Roll",
        price: 15.0,
        img: "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        quantity: 1,
        time: "2025-12-14 18:45:00",
      ),

      // Đơn hàng 3: Nước uống
      CartModel(
        name: "Coca Cola",
        price: 2.0,
        img: "https://images.unsplash.com/photo-1622483767028-3f66f32aef97?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        quantity: 3,
        time: "2025-12-10 09:15:00",
      ),
      CartModel(
        name: "Pepsi",
        price: 2.0,
        img: "https://images.unsplash.com/photo-1629203851122-3726ecdf080e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        quantity: 3,
        time: "2025-12-10 09:15:00",
      ),
    ];

    // ==========================================================
    // 2. LOGIC NHÓM ĐƠN HÀNG
    // ==========================================================
    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<String> orderTimes = cartItemsPerOrder.entries.map((e) => e.key).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: BigText(text: "Lịch sử", color: Colors.white),
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
        actions: [
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 20),
        ],
      ),
      body: ListView.builder(
        itemCount: cartItemsPerOrder.length,
        itemBuilder: (context, index) {
          var timeKey = orderTimes[index];
          List<CartModel> currentOrderItems = getCartHistoryList
              .where((item) => item.time == timeKey)
              .toList();

          return Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hiển thị thời gian
                BigText(
                  text: parseDate(timeKey),
                  color: AppColors.titleColor,
                  size: 18,
                ),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Cột Ảnh
                    Wrap(
                      direction: Axis.horizontal,
                      children: List.generate(
                          currentOrderItems.length > 3 ? 3 : currentOrderItems.length,
                          (imgIndex) {
                        return Container(
                          height: 80,
                          width: 80,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                            // SỬA LẠI LOGIC HIỂN THỊ ẢNH ĐỂ NHẬN LINK ONLINE
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: (currentOrderItems[imgIndex].img != null &&
                                      currentOrderItems[imgIndex].img!.startsWith("http"))
                                  ? NetworkImage(currentOrderItems[imgIndex].img!) // Link online
                                  : NetworkImage("${AppConstants.BASE_URL}/uploads/${currentOrderItems[imgIndex].img ?? ""}"), // Link server nội bộ
                            ),
                          ),
                        );
                      }),
                    ),

                    // Cột Thông tin
                    SizedBox(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SmallText(text: "Tổng cộng", color: AppColors.titleColor),
                          BigText(
                              text: "${currentOrderItems.length} món",
                              color: AppColors.titleColor),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 1, color: AppColors.mainColor)),
                            child: SmallText(text: "Chi tiết", color: AppColors.mainColor),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  String parseDate(String dateString) {
    try {
      DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString);
      var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
      return outputFormat.format(parseDate);
    } catch (e) {
      return dateString;
    }
  }
}