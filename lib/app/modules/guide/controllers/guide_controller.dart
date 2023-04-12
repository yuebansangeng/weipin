import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GuideController extends GetxController {
  var role = 1.obs; //角色 0 招人 1 找工作

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

  void setRoleType(index) {
    role.value = index;
    update();
  }
}
