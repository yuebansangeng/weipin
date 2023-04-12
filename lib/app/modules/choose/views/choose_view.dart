import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/choose_controller.dart';

class ChooseView extends GetView<ChooseController> {
  const ChooseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChooseView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChooseView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
