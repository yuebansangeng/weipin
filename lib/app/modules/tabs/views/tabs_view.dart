import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../services/keepAliveWrapper.dart';
import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: controller.pageController,
      physics: const NeverScrollableScrollPhysics(),
      //禁止左右滑动
      children: controller.pages,
      onPageChanged: (index) {
        controller.setCurrentIndex(index);
      },
    ));
  }
}
