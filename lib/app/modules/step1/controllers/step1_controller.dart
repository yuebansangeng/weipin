import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../models/message_model.dart';
import '../../../services/screenAdapter.dart';
import '../../cinfo/controllers/cinfo_controller.dart';

class Step1Controller extends GetxController {
  TextEditingController nameController = TextEditingController();
  final CInfoController cInfoController = Get.put(CInfoController());

  final formKey = GlobalKey<FormState>();
  var disable = true.obs; //是否允许下一步
  RxInt sex = 0.obs;
  RxString realName = ''.obs;
  Rx<DateTime> birthDay = DateTime.parse('19920101').obs;

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

  void setDisalbe(bool flag) {
    disable.value = flag;
  }

  void setData() {
    //获取数据
    realName.value = cInfoController.cUserInfo.value.realName ?? "";
    nameController.text = realName.value;
    sex.value = cInfoController.cUserInfo.value.sex ?? 0;
    birthDay.value =
        cInfoController.cUserInfo.value.birthDay ?? DateTime.parse('19920101');
    if (cInfoController.cUserInfo.value.realName != null) {
      disable.value = false;
    }
    update();
  }

  void setRealName(String name) {
    realName.value = name;
    cInfoController.cUserInfo.value.realName = name;
    update();
  }

  void setBirthDay(DateTime birth) {
    birthDay.value = birth;
    cInfoController.cUserInfo.value.birthDay = birthDay.value;
    update();
  }

  void setSex(int _sex) {
    sex.value = _sex;
    cInfoController.cUserInfo.value.sex = _sex;
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
      final CInfoController tabs = Get.put(CInfoController());
      tabs.jumpToAnimation(1);
    }
    update();
  }
}
