import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:intl/intl.dart";
import '../home/history_controller.dart';
import '../utils/colors.dart';
import '../widgets/big_text.dart';
import '../widgets/small_text.dart';

class OrderHistory extends StatelessWidget {
  final HistoryController historyController = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Lịch sử mua hàng", size: 20, color: Colors.white),
        backgroundColor: AppColors.mainColor,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => historyController.clearHistory(),
          )
        ],
      ),
      body: Obx(() {
        if (historyController.orderHistory.isEmpty) {
          return Center(child: SmallText(text: "Chưa có đơn hàng nào"));
        }
        return ListView.builder(
          itemCount: historyController.orderHistory.length,
          itemBuilder: (context, index) {
            final order = historyController.orderHistory[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(order.imageUrl,
                          width: 60, height: 60, fit: BoxFit.cover,
                          errorBuilder: (c, e, s) =>
                            Icon(Icons.image_not_supported, size: 60)),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: order.foodName),
                              SmallText(text: order.restaurant),
                            ],
                          ),
                        ),
                        Text("${order.total}đ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Divider(height: 20),
                    SmallText(text: "Mã đơn hàng: ${order.orderId}"),
                    SmallText(text: "Thời gian: ${DateFormat('dd/MM/yyyy - HH:mm').format(order.dateTime)}"),
                    SmallText(text: "Thanh toán: ${order.paymentMethod}"),
                    SmallText(text: "Trạng thái: ${order.deliveryStatus}"),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Chuyển đến trang chi tiết hoặc theo dõi đơn hàng
                        },
                        child: Text("Xem chi tiết", style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
