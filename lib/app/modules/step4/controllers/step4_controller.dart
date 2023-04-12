import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../cinfo/controllers/cinfo_controller.dart';
import '../../../services/httpsClient.dart';
import '../../../models/message_model.dart';
import '../../../services/screenAdapter.dart';
import 'package:flutter/cupertino.dart';

final CInfoController cInfoController = Get.put(CInfoController());

class Step4Controller extends GetxController {
  //TODO: Implement Step4Controller

  HttpsClient httpsClient = HttpsClient();
  FixedExtentScrollController hopeLowSalaryPicker =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController hopeHighSalaryPicker =
      FixedExtentScrollController(initialItem: 1);

  RxInt currentPart = 0.obs; //当前在求职期望中的步骤
  RxInt currentIndex = 2.obs; //当前步骤
  RxBool hasFocus = false.obs; //是否获取焦点
  TextEditingController cityEditController = TextEditingController();
  TextEditingController positionEditController = TextEditingController();
  TextEditingController personController = TextEditingController();
  RxDouble hopeHighSalary = 0.0.obs;
  RxDouble hopeLowSalary = 0.0.obs;
  RxString jobContent = ''.obs; //工作内容
  RxString locationId = ''.obs; //地区id
  RxString locationName = ''.obs; //地区
  RxInt positionId = 0.obs; //期望职位id
  RxString positionName = ''.obs; //地区
  RxString personalAdvantage = ''.obs; //个人优势
  RxString hopePositionName = ''.obs; //期望职位
  RxInt hopePositionId = 0.obs; //期望职位
  final formKey = GlobalKey<FormState>();

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

  setData() {
    locationId.value = cInfoController.cUserInfo.value.locationId ?? "";
    locationName.value = cInfoController.cUserInfo.value.locationName ?? "";
    hopeLowSalary.value = double.parse(
        cInfoController.cUserInfo.value.hopeLowSalary != null
            ? cInfoController.cUserInfo.value.hopeLowSalary.toString()
            : '0.0');
    hopeHighSalary.value = double.parse(
        cInfoController.cUserInfo.value.hopeHighSalary != null
            ? cInfoController.cUserInfo.value.hopeHighSalary.toString()
            : '1000.0');
    personalAdvantage.value =
        cInfoController.cUserInfo.value.personalAdvantage ?? "";
    cityEditController.text =
        cInfoController.cUserInfo.value.locationName ?? "";
    positionEditController.text =
        cInfoController.cUserInfo.value.positionName ?? "";
    hopeLowSalaryPicker = FixedExtentScrollController(
        initialItem: (hopeLowSalary.value ~/ 1000 - 1));
    hopeHighSalaryPicker = FixedExtentScrollController(
        initialItem: (hopeHighSalary.value ~/ 1000) - 1);
    hopePositionName.value =
        cInfoController.cUserInfo.value.hopePositionName ?? "";
    hopePositionId.value = cInfoController.cUserInfo.value.hopePositionId ?? 0;

    personController.text =
        cInfoController.cUserInfo.value.personalAdvantage ?? "";
    update();
  }

  void setCity(id, value) {
    locationId.value = id;
    locationName.value = value;
    cInfoController.cUserInfo.value.locationId = id;
    cInfoController.cUserInfo.value.locationName = value;
    cityEditController.text = value;
    update();
  }

  void setPosition(int id, String value) {
    hopePositionId.value = id;
    hopePositionName.value = value;
    cInfoController.cUserInfo.value.hopePositionId = id;
    cInfoController.cUserInfo.value.hopePositionName = value;
    positionEditController.text = value;
    update();
  }

  void setHopeLowSalary(value) {
    hopeLowSalary.value = double.parse((value * 1000).toString());
    cInfoController.cUserInfo.value.hopeLowSalary =
        double.parse((value * 1000).toString());
    update();
  }

  void setHopeHighSalary(value) {
    hopeHighSalary.value = double.parse((value * 1000).toString());
    cInfoController.cUserInfo.value.hopeHighSalary =
        double.parse((value * 1000).toString());
    update();
  }

  void setPersonalAdvantage(value) {
    personalAdvantage.value = value;
    cInfoController.cUserInfo.value.personalAdvantage = value;
    update();
  }

  void toNext() async {
    CInfoController cInfoController = Get.put(CInfoController());
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
      if (currentPart.value < 1) {
        currentPart.value = currentPart.value + 1;
      } else {
        Get.toNamed('/home');
      }
    }
    update();
  }
}
