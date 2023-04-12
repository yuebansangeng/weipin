import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cresume_controller.dart';

class CresumeView extends GetView<CresumeController> {
  const CresumeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CresumeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CresumeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
