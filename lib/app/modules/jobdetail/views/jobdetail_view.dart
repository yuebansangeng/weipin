import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/jobdetail_controller.dart';

class JobdetailView extends GetView<JobdetailController> {
  const JobdetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JobdetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'JobdetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
