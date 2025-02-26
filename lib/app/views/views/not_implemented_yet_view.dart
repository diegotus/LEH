import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../global_widgets/custom_appbar.dart';

class NotImplementedYetView extends GetView {
  const NotImplementedYetView({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        title,
        true,
        true,
        const [],
        () {},
      ),
      body: const Center(
        child: Text(
          'Paj sa poko prè',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
