import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../services/httpsClient.dart';
import '../../../services/storage.dart';

import '../../../models/user_model.dart';
import '../../../services/screenAdapter.dart';
import '../../guide/views/guide_view.dart';
import '../../home/views/home_view.dart';
import '../../cinfo/views/cinfo_view.dart';
import '../../verifyPhone/views/verify_phone_view.dart';

class InitialPageController extends GetxController {
  Rx<UserModel> userInfo = UserModel().obs;
  HttpsClient httpsClient = HttpsClient();
  RxBool inited = true.obs;

  @override
  void onInit() {
    Timer(Duration(seconds: 1), () async {
      String ticket = await Storage.getData("ticket") ?? '';
      if (ticket != "") {
        getUserState(ticket);
      } else {
        // 跳转到欢迎页
        Get.offAndToNamed("/guide");
      }
    });

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

  Future getUserState(ticket) async {
    Get.offAndToNamed("/home"); //直接跳转到首页
    var apiUri = "user/getUserState?ticket=${ticket}";
    var response = await httpsClient.get(apiUri);
    if (response != null) {
      if (response.data["returncode"] == 0) {
        if (response.data['result'] != null) {
          print('result ${response.data["result"]}');
          userInfo.value = UserModel.fromJson(response.data['result']);
          if (userInfo.value.identityC == 1 || userInfo.value.identityB == 1) {
            if (userInfo.value.registerState == 0) {
              Get.offAndToNamed("/verify-phone");
            } else {
              if (userInfo.value.dataCompletionB == 1 ||
                  userInfo.value.dataCompletionC == 1) {
                Get.offAndToNamed("/home"); //直接跳转到首页
              } else {
                Get.offAndToNamed("/cinfo"); //直接跳转到首页
              }
            }
          }
        } else {
          //跳转到欢迎页
          Get.off(const GuideView());
        }
      }
    } else {
      Get.snackbar("", "网络连接失败，请重试",
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(16),
              ScreenAdapter.height(0),
              ScreenAdapter.width(16),
              ScreenAdapter.height(18)));
    }
  }
}
