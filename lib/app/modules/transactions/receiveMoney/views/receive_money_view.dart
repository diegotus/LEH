import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/receive_money_controller.dart';

class ReceiveMoneyView extends GetView<ReceiveMoneyController> {
  const ReceiveMoneyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReceiveMoneyView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReceiveMoneyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
