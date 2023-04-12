import 'package:get/get.dart';
import '../../../models/message_model.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/httpsClient.dart';
import 'package:flutter/material.dart';
import '../../cinfo/controllers/cinfo_controller.dart';
import '../../step4/controllers/step4_controller.dart';

class PositionController extends GetxController {
  //TODO: Implement PositionController
  RxInt currentIndex = 2.obs; //当前步骤
  RxString searchText = ''.obs; //搜索内容
  RxList searchList = [].obs; //搜索返回内容
  RxBool hasFocus = false.obs;

  TextEditingController editingController = TextEditingController();
  HttpsClient httpsClient = HttpsClient();

  @override
  void onInit() {
    getSearchPositionList(searchText.value);
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

  void toNext(int id, String value) {
    Step4Controller step5 = Get.put(Step4Controller());
    step5.setPosition(id, value);
    Get.back();
  }

  void setFocus(value) {
    hasFocus.value = value;
  }

  //职位集合
  Future<MessageModel> getSearchPositionList(searchValue) async {
    var apiUri = "user/getSearchPositionList?searchValue=${searchValue}";
    var response = await httpsClient.get(apiUri);
    print('search position出参：${response}');
    if (response != null) {
      if (response.data["returncode"] == 0) {
        searchList.value = response.data['result'];
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
