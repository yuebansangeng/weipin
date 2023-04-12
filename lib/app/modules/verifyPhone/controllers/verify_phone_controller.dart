import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../services/httpsClient.dart';
import '../../../models/message_model.dart';

class VerifyPhoneController extends GetxController {
  final TextEditingController editingController = TextEditingController();
  HttpsClient httpsClient = HttpsClient();
  var comfirm = false.obs; //是否同意协议
  var tips = false.obs; //是否显示tips
  var phone = "".obs; //当前验证手机号

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
    print('verify onclose');
    super.onClose();
  }

  void setComfirm(value) {
    comfirm.value = value;
    update();
  }

  void changeTipsStatus(value) {
    tips.value = value;
    update();
  }

  Future<MessageModel> sendVerificationCode(phone) async {
    const apiUri = "user/sendVerificationCode";
    var response = await httpsClient.post(apiUri, data: {"phone": phone});
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
