import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../cinfo/controllers/cinfo_controller.dart';
import '../../../models/message_model.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/httpsClient.dart';

class Step3Controller extends GetxController {
  final CInfoController cInfoController = Get.put(CInfoController());
  HttpsClient httpsClient = HttpsClient();

  //TODO: Implement Step3Controller
  RxInt currentPart = 0.obs; //当前在教育经历中的步骤
  RxInt currentIndex = 1.obs; //当前步骤
  RxInt qualificationsId = 0.obs; // 选择学历 初中及以下 高中 中专/中技 大专 本科 硕士 博士
  RxString qualificationsName = ''.obs; //学历名称
  RxInt qualificationsType = 0.obs; //全日制 非全日制
  RxString schoolName = ''.obs; //学校
  RxString searchText = ''.obs; //搜索内容
  RxList searchList = [].obs; //搜索返回内容
  RxString searchSubjectText = ''.obs; //搜索专业
  RxString specializedSubject = ''.obs; //专业
  RxList searchSubjectList = [].obs; //搜索返回内容
  Rx<DateTime> schoolStartTime = DateTime.now().obs;
  Rx<DateTime> schoolEndTime = DateTime.now().obs;
  TextEditingController editingController = TextEditingController();
  TextEditingController editingSchoolController = TextEditingController();
  RxBool hasFocus = false.obs; //是否获取焦点
  RxBool hasMajorFocus = false.obs; //是否获取焦点
  final formKey = GlobalKey<FormState>();
  final formKey_2 = GlobalKey<FormState>();

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

  void setData() {
    qualificationsId.value =
        cInfoController.cUserInfo.value.qualificationsId ?? 0;
    qualificationsType.value =
        cInfoController.cUserInfo.value.qualificationsType ?? 0;
    schoolName.value = cInfoController.cUserInfo.value.schoolName ?? "";
    editingController.text = cInfoController.cUserInfo.value.schoolName ?? "";
    specializedSubject.value =
        cInfoController.cUserInfo.value.specializedSubject ?? "";
    editingSchoolController.text =
        cInfoController.cUserInfo.value.specializedSubject ?? "";
    schoolStartTime.value = cInfoController.cUserInfo.value.schoolStartTime!;
    schoolEndTime.value = cInfoController.cUserInfo.value.schoolEndTime!;
    update();
  }

  void toNext() async {
    MessageModel model = await cInfoController
        .perfectInformationC(cInfoController.cUserInfo.value.toJson());
    if (model.result == 'error') {
      Get.snackbar("", model.message,
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(16),
              ScreenAdapter.height(0),
              ScreenAdapter.width(16),
              ScreenAdapter.height(18)));
    } else if (model.result == 'loginerror') {
      Get.snackbar("", model.message,
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(16),
              ScreenAdapter.height(0),
              ScreenAdapter.width(16),
              ScreenAdapter.height(18)));
      Get.toNamed('/tabs');
    } else {
      if (currentPart.value < 3) {
        currentPart.value = currentPart.value + 1;
      } else {
        final CInfoController tabs = Get.put(CInfoController());
        tabs.jumpToAnimation(3);
      }
    }
    update();
  }

  void setDegree(id, value) {
    qualificationsId.value = id;
    qualificationsName.value = value;
    if (id != 4) {
      qualificationsType.value = 0;
      cInfoController.cUserInfo.value.qualificationsType = 0;
    }
    cInfoController.cUserInfo.value.qualificationsId = id;
    cInfoController.cUserInfo.value.qualificationsName = value;
    update();
  }

  void setType(value) {
    qualificationsType.value = value;
    cInfoController.cUserInfo.value.qualificationsType = value;
    update();
  }

  void setSchoolName(value) {
    schoolName.value = value;
    cInfoController.cUserInfo.value.schoolName = value;
    update();
  }

  void setSpecializedSubject(id, value) {
    specializedSubject.value = value;
    cInfoController.cUserInfo.value.specializedSubject = value;
    cInfoController.cUserInfo.value.specializedId = id;
    update();
  }

  void setSchoolStartTime(value) {
    schoolStartTime.value = value;
    cInfoController.cUserInfo.value.schoolStartTime = value;
    update();
  }

  void setSchoolEndTime(value) {
    schoolEndTime.value = value;
    cInfoController.cUserInfo.value.schoolEndTime = value;
    update();
  }

  void setFocus(value) {
    hasFocus.value = value;
    update();
  }

  void sethasMajorFocus(value) {
    hasMajorFocus.value = value;
    update();
  }

  //查找学校
  Future<MessageModel> getSearchSchoolList(searchValue) async {
    var apiUri = "user/getSearchSchoolList?searchValue=${searchValue}";
    var response = await httpsClient.get(apiUri);
    print('search1 position出参：${response}');
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

  //查找专业
  Future<MessageModel> getSearchSpecializedList(searchValue) async {
    searchSubjectList.value = [];
    var apiUri = "user/getSearchSpecializedList?searchValue=${searchValue}";
    var response = await httpsClient.get(apiUri);
    print('search position出参：${response}');
    if (response != null) {
      if (response.data["returncode"] == 0) {
        searchSubjectList.value = response.data['result'];
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
