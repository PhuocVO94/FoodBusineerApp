import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: BigText(text: "Theo dõi đơn hàng", size: 20, color: Colors.white),
        backgroundColor: AppColors.mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // PHẦN BẢN ĐỒ (Giả lập)
          Expanded(
            child: Container(
              width: double.maxFinite,
              color: Colors.grey[200], // Màu nền thay thế bản đồ
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_outlined, size: 100, color: Colors.grey[400]),
                        SmallText(text: "Google Map View Here"),
                                              ],
                    ),
                  ),

                  // Card trạng thái vận chuyển nổi trên bản đồ
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time_filled, color: AppColors.mainColor, size: 30),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: "Thời gian ước tính", size: 16),
                              SmallText(text: "20 - 30 Phút"),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // PHẦN THÔNG TIN TRẠNG THÁI ĐƠN HÀNG
          Container(
            height: 300, // Chiều cao cố định cho panel
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -5),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // Thông tin tài xế
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"), // Ảnh avatar tài xế
                      backgroundColor: AppColors.mainColor,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: "Nguyen Anh Khue"),
                          SmallText(text: "Shipper  4.9 ⭐"),
                        ],
                      ),
                    ),
                    
                    // Nút gọi điện
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.mainColor,
                      ),
                      child: Icon(Icons.phone, color: Colors.white),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Divider(thickness: 1, color: Colors.grey[200]),
                SizedBox(height: 10),
                
                // Timeline trạng thái đơn hàng (Thủ công)
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildTimelineItem("Order Placed", "Your order has been received", true, false),
                      _buildTimelineItem("Preparing", "Kitchen is preparing your food", true, false),
                      _buildTimelineItem("On the way", "Shipper picked up your order", true, false),
                      _buildTimelineItem("Delivered", "Enjoy your meal!", false, true),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget xây dựng từng dòng trạng thái (Timeline)
  Widget _buildTimelineItem(String title, String subtitle, bool isActive, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cột Line và Dot
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isActive ? AppColors.mainColor : Colors.grey[300],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40, // Độ dài đường nối
                color: isActive ? AppColors.mainColor : Colors.grey[300],
              ),
          ],
        ),
        SizedBox(width: 15),
        // Cột nội dung text
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.black : Colors.grey,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}