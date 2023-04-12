import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/httpsClient.dart';
import '../../../services/storage.dart';

import '../../../models/user_model.dart';

import '../../login/controllers/login_controller.dart';
import '../../verifyPhone/views/verify_phone_view.dart';
import '../../login/views/login_view.dart';
import '../../guide/views/guide_view.dart';
import '../../cinfo/views/cinfo_view.dart';
import '../../area/views/area_view.dart';
import '../../../services/screenAdapter.dart';

class TabsController extends GetxController {
  RxInt currentIndex = 0.obs;
  HttpsClient httpsClient = HttpsClient();
  PageController pageController = PageController();
  final List<Widget> pages = [
    // const GuideView(),
    // VerifyPhoneView(),
    // LoginView(),
    // const CinfoView(),
    // const AreaView(),
  ];
  RxBool showBack = false.obs;
  var userInfo = UserModel().obs;
  LoginController loginController = Get.put(LoginController());

  @override
  void onInit() async {
    //用于控制默认加载的tabs选项
    pageController = Get.arguments != null
        ? PageController(initialPage: Get.arguments["initialPage"])
        : PageController(initialPage: 0);

    update();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    print('close');
    super.onClose();
  }

  @override
  void setCurrentIndex(index) {
    pageController.jumpToPage(index);
    // update();
  }

  @override
  void jumpTo(index) {
    // currentIndex.value = index;
    pageController.jumpToPage(index);
    // update();
  }

  void jumpToAnimation(index) {
    if (index == 3) {
      userInfo.value = loginController.userInfo.value;
      if (userInfo.value.dataCompletionC == 0 ||
          userInfo.value.dataCompletionB == 0) {
        pageController.animateToPage(3,
            duration: const Duration(milliseconds: 400), curve: Curves.linear);
      } else {
        //跳转到首页
        Get.toNamed('/home');
      }
    } else {
      try {
        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 400), curve: Curves.linear);
      } catch (err) {
        print(err);
      }
    }

    // update();
  }
}
