import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../joblist/views/joblist_view.dart';
import '../../ccenter/views/ccenter_view.dart';

class HomeController extends GetxController {
  //TODO: Implement CcenterController
  RxInt currentIndex = 1.obs;

  PageController pageController = Get.arguments != null
      ? PageController(initialPage: Get.arguments["initialPage"])
      : PageController(initialPage: 1);
  final List<Widget> pages = [
    const JoblistView(),
    const CcenterView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCurrentIndex(index) {
    currentIndex.value = index;
    update();
  }
}
