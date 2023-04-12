import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/joblist_controller.dart';

class JoblistView extends GetView<JoblistController> {
  const JoblistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'JoblistView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
