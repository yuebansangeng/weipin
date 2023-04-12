import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AreaModule {
  String? title;
  String? num;

  AreaModule.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    num = json['num'];
  }
}

class AreaModuleList {
  List<AreaModule>? list;
  String? name;

  AreaModuleList({this.list, this.name});

  AreaModuleList.fromJson(Map<String, dynamic> json) {
    list = <AreaModule>[];
    (json['list'] as List).forEach((v) {
      list?.add(new AreaModule.fromJson((v)));
    });
    name = json['name'];
  }
}

class AreaController extends GetxController {
  //TODO: Implement AreaController
  final count = 0.obs;
  RxList<AreaModule> area = <AreaModule>[].obs;

  final ScrollController scrollController = ScrollController();

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

  Object fromJson(Map<String, dynamic> json) {
    var title = json['title'];
    var num = json['num'];
    var obj = {title: title, num: num};
    return obj;
  }

  void setScrollHeight(height) {
    scrollController.jumpTo(height);
  }
}
