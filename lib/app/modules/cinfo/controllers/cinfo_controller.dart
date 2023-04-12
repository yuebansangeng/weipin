import 'dart:ffi';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../models/message_model.dart';
import '../../../models/c_model.dart';
import '../../../services/httpsClient.dart';
import '../../../services/storage.dart';

import '../../step1/controllers/step1_controller.dart';
import '../../step2/controllers/step2_controller.dart';
import '../../step3/controllers/step3_controller.dart';
import '../../step4/controllers/step4_controller.dart';

import '../../step1/views/step1_view.dart';
import '../../step2/views/step2_view.dart';
import '../../step3/views/step3_view.dart';
import '../../step4/views/step4_view.dart';
import '../../../services/screenAdapter.dart';

class CInfoController extends GetxController {
  var currentIndex = 0.obs; //当前步骤
  PageController pageController = PageController(initialPage: 0);
  HttpsClient httpsClient = HttpsClient();
  var cUserInfo = CModel(
          sex: 0,
          identity: 0,
          jobStatusId: 0,
          birthDay: DateTime.parse('19920101'),
          firstWorkingTime:
              DateTime.parse('${DateTime.now().year.toString()}0101'),
          recentlyCompanyStartTime:
              DateTime.parse('${DateTime.now().year.toString()}0101'),
          recentlyCompanyEndTime:
              DateTime.parse('${DateTime.now().year.toString()}0101'),
          schoolStartTime:
              DateTime.parse('${DateTime.now().year.toString()}0101'),
          schoolEndTime:
              DateTime.parse('${DateTime.now().year.toString()}0101'))
      .obs;
  final List<Widget> pages = [
    const Step1View(),
    Step2View(),
    Step3View(),
    Step4View(),
  ];

  @override
  void onInit() async {
    print('to cinfo');
    //拿到初始状态接口
    String ticket = await Storage.getData("ticket") ?? '';
    getUserMemberC(ticket).then((res) {
      if (res.result == 'error') {
        Get.snackbar("", res.message,
            padding: EdgeInsets.fromLTRB(
                ScreenAdapter.width(16),
                ScreenAdapter.height(0),
                ScreenAdapter.width(16),
                ScreenAdapter.height(18)));
      } else if (res.result == 'loginerror') {
        Get.snackbar("", res.message,
            padding: EdgeInsets.fromLTRB(
                ScreenAdapter.width(16),
                ScreenAdapter.height(0),
                ScreenAdapter.width(16),
                ScreenAdapter.height(18)));
        Get.toNamed('/verify-phone');
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

  void setCurrentIndex(index) {
    currentIndex.value = index;
    update();
  }

  @override
  void jumpToAnimation(index, [bool? isBack]) {
    isBack ??= false;
    if (!isBack) {
      perfectInformationC(cUserInfo.value.toJson()).then((res) {
        if (res.result == 'loginerror') {
          Get.snackbar("", res.message,
              padding: EdgeInsets.fromLTRB(
                  ScreenAdapter.width(16),
                  ScreenAdapter.height(0),
                  ScreenAdapter.width(16),
                  ScreenAdapter.height(18)));
          Get.toNamed('/verify-phone');
        }
      });
    }
    setCurrentIndex(index);
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
    // update();
  }

  //完善个人信息接口
  Future<MessageModel> perfectInformationC(data) async {
    String ticket = await Storage.getData("ticket") ?? '';
    data['ticket'] = ticket;
    print('写入接口入参：${data}');
    const apiUri = "user/perfectInformationC";
    var response = await httpsClient.post(apiUri, data: data);
    print('写入接口出参：${response}');
    if (response != null) {
      if (response.data["returncode"] == 0) {
        return MessageModel(
            message: response.data["message"] ?? '', result: 'success');
      } else {
        if (response.data["returncode"] == 5) {
          //登录过期状态
          return MessageModel(
              message: response.data["message"] ?? '', result: 'loginerror');
        }
        return MessageModel(
            message: response.data["message"] ?? '', result: 'error');
      }
    }
    return MessageModel(message: "网络连接失败，请重试", result: 'error');
  }

  //获取个人信息接口
  Future<MessageModel> getUserMemberC(ticket) async {
    print('get接口入参：${ticket}');
    var apiUri = "user/getUserMemberC?ticket=${ticket}";
    var response = await httpsClient.get(apiUri);
    print('get接口出参：${response}');
    if (response != null) {
      if (response.data["returncode"] == 0) {
        if (response.data['result'] != null) {
          cUserInfo.value = CModel.fromJson(response.data['result'])!;
          Step1Controller step1Controller = Get.put(Step1Controller());
          Step2Controller step2Controller = Get.put(Step2Controller());
          Step3Controller step3Controller = Get.put(Step3Controller());
          Step4Controller step4Controller = Get.put(Step4Controller());

          step1Controller.setData();
          step2Controller.setData();
          step3Controller.setData();
          step4Controller.setData();
          update();
        }
        return MessageModel(
            message: response.data["message"] ?? '', result: 'success');
      } else {
        if (response.data["returncode"] == 5) {
          //登录过期状态
          return MessageModel(
              message: response.data["message"] ?? '', result: 'loginerror');
        }
        return MessageModel(
            message: response.data["message"] ?? '', result: 'error');
      }
    }
    return MessageModel(message: "网络连接失败，请重试", result: 'error');
  }
}
