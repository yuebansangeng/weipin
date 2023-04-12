import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../services/keepAliveWrapper.dart';
import '../../step2/controllers/step2_controller.dart';
import '../../step3/controllers/step3_controller.dart';
import '../../step4/controllers/step4_controller.dart';
import '../controllers/cinfo_controller.dart';

import '../../../../widget/more.dart';

class CinfoView extends GetView<CInfoController> {
  const CinfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Step2Controller step2Controller = Get.put(Step2Controller());
    final Step3Controller step3Controller = Get.put(Step3Controller());
    final Step4Controller step4Controller = Get.put(Step4Controller());

    return Obx(() => More(
          showBackBtn: controller.currentIndex.value == 0 ? false : true,
          onTabClik: () {
            if (controller.currentIndex.value == 1) {
              if (step2Controller.currentPart.value == 0) {
                controller.jumpToAnimation(
                    controller.currentIndex.value - 1, true);
              } else {
                step2Controller.currentPart.value =
                    step2Controller.currentPart.value - 1;
              }
            } else if (controller.currentIndex.value == 2) {
              if (step3Controller.currentPart.value == 0) {
                controller.jumpToAnimation(controller.currentIndex.value - 1);
              } else {
                step3Controller.currentPart.value =
                    step3Controller.currentPart.value - 1;
              }
            } else if (controller.currentIndex.value == 3) {
              if (step4Controller.currentPart.value == 0) {
                controller.jumpToAnimation(controller.currentIndex.value - 1);
              } else {
                step4Controller.currentPart.value =
                    step4Controller.currentPart.value - 1;
              }
            }
          },
          child: KeepAliveWrapper(
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              //禁止左右滑动
              children: controller.pages,
              onPageChanged: (index) {
                controller.setCurrentIndex(index);
              },
            ),
          ),
        ));
  }
}
