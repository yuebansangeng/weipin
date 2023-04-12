import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cconfig_controller.dart';

class CconfigView extends GetView<CconfigController> {
  const CconfigView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CconfigView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CconfigView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
