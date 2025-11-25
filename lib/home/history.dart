import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử"),
      ),
      body: const Center(
        child: Text(
          "Lịch sử mua hàng",
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
