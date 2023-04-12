import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../cinfo/controllers/cinfo_controller.dart';
import '../../../models/message_model.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/httpsClient.dart';

class Step2Controller extends GetxController {
  final CInfoController cInfoController = Get.put(CInfoController());
  HttpsClient httpsClient = HttpsClient();
  RxBool hasFocus = false.obs; //是否获取焦点
  RxBool hasCompanyFocus = false.obs; //是否获取焦点
  final formKey = GlobalKey<FormState>();
  final formKey_2 = GlobalKey<FormState>();

  RxInt currentIndex = 0.obs; //当前步骤
  RxInt identity = 0.obs; //身份 0 职场人 1 学生
  RxInt jobStatusId = 0.obs; //求职状态: 0 离职-随时到岗 1 在职-月内到岗 2 在职-考虑机会 3 在职-暂不考虑
  RxString jobStatusName =
      ''.obs; //求职状态: 0 离职-随时到岗 1 在职-月内到岗 2 在职-考虑机会 3 在职-暂不考虑

  Rx<DateTime> firstWorkingTime = DateTime.now().obs; //第一次参加工作时间

  RxInt currentPart = 0.obs; //当前在工作经历的第几步

  RxString searchText = ''.obs; //搜索内容
  RxList positionList = [].obs; //职位树形结构
  RxInt positionId = 0.obs;
  RxString positionName = ''.obs;

  RxList searchPositionList = [].obs; //搜索职位
  RxInt selectIndex = 0.obs;

  RxString recentlyCompany = ''.obs;
  RxString jobContent = ''.obs;
  RxBool hasSelect = false.obs; //只能提交数据库中拥有的职位，自己填写的不能提交

  Rx<DateTime> recentlyCompanyStartTime = DateTime.now().obs; //入职时间
  Rx<DateTime> recentlyCompanyEndTime = DateTime.now().obs; //离职时间

  ScrollController scrollController = ScrollController();
  TextEditingController editingController = TextEditingController();
  TextEditingController editingCompanyController = TextEditingController();
  TextEditingController editingLifeController = TextEditingController();

  @override
  void onInit() {
    getPositionTree();
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
    identity.value = cInfoController.cUserInfo.value.identity ?? 0;
    jobStatusId.value = cInfoController.cUserInfo.value.jobStatusId ?? 0;
    firstWorkingTime.value =
        cInfoController.cUserInfo.value.firstWorkingTime ?? DateTime.now();
    positionId.value = cInfoController.cUserInfo.value.positionId ?? 0;
    positionName.value = cInfoController.cUserInfo.value.positionName ?? '';
    if (positionName.value != "") {
      hasSelect.value = true;
    }
    recentlyCompany.value =
        cInfoController.cUserInfo.value.recentlyCompany ?? "";
    editingCompanyController.text =
        cInfoController.cUserInfo.value.recentlyCompany ?? '';

    recentlyCompanyStartTime.value =
        cInfoController.cUserInfo.value.recentlyCompanyStartTime!;
    recentlyCompanyEndTime.value =
        cInfoController.cUserInfo.value.recentlyCompanyEndTime!;
    jobContent.value = cInfoController.cUserInfo.value.jobContent ?? "";
    editingLifeController.text =
        cInfoController.cUserInfo.value.jobContent ?? "";

    update();
  }

  //获取职位树
  Future<MessageModel> getPositionTree() async {
    const apiUri = "user/getPositionTree";
    var response = await httpsClient.get(apiUri);
    print('position出参：${response}');
    if (response != null) {
      if (response.data["returncode"] == 0) {
        positionList.value = response.data['result'] ?? [];
        return MessageModel(
            message: response.data["message"] ?? '', result: 'success');
      } else {
        return MessageModel(
            message: response.data["message"] ?? '', result: 'error');
      }
    }
    return MessageModel(message: "网络连接失败，请重试", result: 'error');
  }

  //查找职位
  Future<MessageModel> getSearchPositionList(searchValue) async {
    var apiUri = "user/getSearchPositionList?searchValue=${searchValue}";
    var response = await httpsClient.get(apiUri);
    print('search position出参：${response}');
    if (response != null) {
      if (response.data["returncode"] == 0) {
        searchPositionList.value = response.data['result'] ?? [];
        return MessageModel(message: '', result: 'success');
      } else {
        return MessageModel(
            message: response.data["message"] ?? '', result: 'error');
      }
    }
    return MessageModel(message: "网络连接失败，请重试", result: 'error');
  }

  void setSelectIndex(index) {
    selectIndex.value = index;
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
      if (currentPart.value < 4) {
        currentPart.value = currentPart.value + 1;
      } else {
        final CInfoController tabs = Get.put(CInfoController());
        tabs.jumpToAnimation(2);
      }
    }
    update();
  }

  void setJobStatus(int id, String value) {
    jobStatusId.value = id;
    cInfoController.cUserInfo.value.jobStatusId = id;
    jobStatusName.value = value;
    cInfoController.cUserInfo.value.jobStatusName = value;
    update();
  }

  void setIdentity(int value) {
    identity.value = value;
    cInfoController.cUserInfo.value.identity = value;
    update();
  }

  void setFirstWorkingTime(DateTime value) {
    firstWorkingTime.value = value;
    cInfoController.cUserInfo.value.firstWorkingTime = value;
    update();
  }

  void setPositionId(int id, String value) {
    positionId.value = id;
    cInfoController.cUserInfo.value.positionId = id;
    positionName.value = value;
    cInfoController.cUserInfo.value.positionName = value;
    editingController.text = cInfoController.cUserInfo.value.positionName ?? '';
    update();
  }

  void setRecentlyCompany(String value) {
    recentlyCompany.value = value;
    cInfoController.cUserInfo.value.recentlyCompany = value;
    editingCompanyController.text = value;
    update();
  }

  void setRecentlyCompanyStartTime(DateTime value) {
    recentlyCompanyStartTime.value = value;
    cInfoController.cUserInfo.value.recentlyCompanyStartTime = value;
    update();
  }

  void setRecentlyCompanyEndTime(DateTime value) {
    recentlyCompanyEndTime.value = value;
    cInfoController.cUserInfo.value.recentlyCompanyEndTime = value;
    update();
  }

  void setJobContent(String value) {
    jobContent.value = value;
    cInfoController.cUserInfo.value.jobContent = value;
    update();
  }

  void setFocus(value) {
    hasFocus.value = value;
    update();
  }

  void setCompanyFocus(value) {
    hasCompanyFocus.value = value;
    update();
  }
}
