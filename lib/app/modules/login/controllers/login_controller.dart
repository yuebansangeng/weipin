import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../services/storage.dart';
import '../../../services/httpsClient.dart';

import '../../../models/message_model.dart';
import '../../../models/user_model.dart';
import 'dart:async';

class LoginController extends GetxController {
  final TextEditingController editingCodeController = TextEditingController();
  var show_code = false.obs; //是否显示验证码
  var periodicTimer;
  RxInt seconds = 60.obs;
  var userInfo = UserModel().obs;
  HttpsClient httpsClient = HttpsClient();
  RxString phone = ''.obs;

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
    print('login onclose');
    super.onClose();
  }

  setVerifyCode() {
    editingCodeController.text = '';
    update();
  }

  countDown() {
    if (periodicTimer != null) return;
    seconds.value = 60;
    periodicTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      seconds.value--;
      if (seconds.value <= 0) {
        periodicTimer = null;
        timer.cancel();
      }
      update();
    });
  }

  //登录注册
  Future<MessageModel> regOrLoginByMobileCode(data) async {
    const apiUri = "user/regOrLoginByMobileCode";
    var response = await httpsClient.post(apiUri, data: data);
    if (response != null) {
      if (response.data["returncode"] == 0) {
        userInfo.value = UserModel.fromJson(response.data["result"]);
        await Storage.setData("ticket", userInfo.value.ticket);
        if (userInfo.value.dataCompletionC == 0 ||
            userInfo.value.dataCompletionB == 0) {
          Get.offAndToNamed('/cinfo'); //去到简历完善
        } else {
          Get.offAndToNamed('/home'); //去到首页
        }
        return MessageModel(
            message: response.data["message"] ?? '', result: 'success');
      } else {
        return MessageModel(
            message: response.data["message"] ?? '', result: 'error');
      }
    }
    return MessageModel(message: "网络连接失败，请重试", result: 'error');
  }

  //登出接口
  Future<MessageModel> setLogOff(ticket) async {
    // return MessageModel(message: "我点击登出啦", result: 'error');
    const apiUri = "user/setLogOff";
    var response = await httpsClient.post(apiUri, data: {"ticket": ticket});
    if (response != null) {
      if (response.data["returncode"] == 0) {
        return MessageModel(
            message: response.data["message"] ?? '', result: 'success');
      } else {
        return MessageModel(
            message: response.data["message"] ?? '', result: 'error');
      }
    }
    return MessageModel(message: "网络连接失败，请重试", result: 'error');
  }
}
