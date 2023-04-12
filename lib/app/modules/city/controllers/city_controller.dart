import 'package:get/get.dart';
import '../../../models/message_model.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/httpsClient.dart';
import 'package:flutter/material.dart';
import '../../cinfo/controllers/cinfo_controller.dart';
import '../../step4/controllers/step4_controller.dart';

class CityController extends GetxController {
  //TODO: Implement CityController
  HttpsClient httpsClient = HttpsClient();
  RxInt currentIndex = 2.obs; //当前步骤
  RxString searchText = ''.obs; //搜索内容
  RxList searchProvinceList = [].obs; //搜索返回内容
  RxList provinceList = [].obs; //搜索返回内容

  TextEditingController editingController = TextEditingController();
  RxBool hasFocus = false.obs;

  @override
  void onInit() {
    getLocationList();
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

  void toNext(String id, String value) {
    final Step4Controller step5 = Get.put(Step4Controller());
    step5.setCity(id, value);
    Get.back();
  }

  void setFocus(value) {
    hasFocus.value = value;
  }

  //查找地区
  Future<MessageModel> getSearchLocationList(searchValue) async {
    searchValue = searchValue ?? "";
    var apiUri = "user/getSearchLocationList?searchValue=${searchValue}";
    var response = await httpsClient.get(apiUri);
    if (response != null) {
      if (response.data["returncode"] == 0) {
        searchProvinceList.value = response.data['result'];
        return MessageModel(
            message: response.data["message"] ?? '', result: 'success');
      } else {
        return MessageModel(
            message: response.data["message"] ?? '', result: 'error');
      }
    }
    return MessageModel(message: "网络连接失败，请重试", result: 'error');
  }

  //地区集合
  Future<MessageModel> getLocationList() async {
    var apiUri = "user/getLocationList";
    var response = await httpsClient.get(apiUri);
    if (response != null) {
      if (response.data["returncode"] == 0) {
        provinceList.value = response.data['result'];
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
