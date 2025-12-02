import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'id': 'DH001',
        'date': '1/11/2025',
        'status': 'Đang giao',
        'total': '150.000đ',
      },
      {
        'id': 'DH002',
        'date': '1/11/2025',
        'status': 'Đã giao',
        'total': '250.000đ',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Đơn hàng của tôi")),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.receipt_long, color: Color.fromARGB(255, 137, 218, 208)),
              title: Text("Mã đơn: ${order['id']}"),
              subtitle: Text("Ngày: ${order['date']} - Trạng thái: ${order['status']}"),
              trailing: Text(order['total']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
              },
            ),
          );
        },
      ),
    );
  }
}
