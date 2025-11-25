import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
      ),
      body: const Center(
        child: Text(
          "Danh sách giỏ hàng",
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
