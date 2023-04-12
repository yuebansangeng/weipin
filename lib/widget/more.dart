import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/services/keepAliveWrapper.dart';
import '../app/services/screenAdapter.dart';
import '../app/services/weipinIcon.dart';
import '../app/modules/login/controllers/login_controller.dart';
import '../app/services/storage.dart';
import '../app/models/message_model.dart';
import '../app/modules/tabs/controllers/tabs_controller.dart';

class More extends StatelessWidget {
  final Widget child;
  final bool showBackBtn;
  final void Function() onTabClik;

  const More(
      {super.key,
      required this.child,
      required this.showBackBtn,
      required this.onTabClik});

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              //消除阴影
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (showBackBtn)
                      InkWell(
                        onTap: () {
                          onTabClik();
                        },
                        child: Icon(weipinIcon.back,
                            size: ScreenAdapter.height(36),
                            color: const Color.fromRGBO(51, 51, 51, 1)),
                      )
                    else
                      const Text(''),
                    GestureDetector(
                      onTap: () {
                        show();
                      },
                      child: Text(
                        '更多操作',
                        style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(14),
                            color: const Color.fromRGBO(162, 199, 219, 1)),
                      ),
                    ),
                  ])),
          body: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: child)),
    );
  }

  show() {
    Get.bottomSheet(Container(
      margin: EdgeInsets.only(
        left: ScreenAdapter.width(8),
        right: ScreenAdapter.width(8),
      ),
      height: ScreenAdapter.height(290),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: ScreenAdapter.height(169),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: ScreenAdapter.height(45),
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: ScreenAdapter.height(1),
                              color: const Color.fromRGBO(204, 204, 204, 1)),
                        ),
                        color: const Color.fromRGBO(245, 245, 245, 0.70)),
                    child: Center(
                        child: Text(
                      '更多操作',
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(14),
                          color: const Color.fromRGBO(153, 153, 153, 1)),
                    )),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      Get.snackbar("", "暂未开通，敬请期待～",
                          padding: EdgeInsets.fromLTRB(
                              ScreenAdapter.width(16),
                              ScreenAdapter.height(0),
                              ScreenAdapter.width(16),
                              ScreenAdapter.height(18)));
                    },
                    child: Container(
                      height: ScreenAdapter.height(61),
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: ScreenAdapter.height(1),
                                color: const Color.fromRGBO(204, 204, 204, 1)),
                          ),
                          color: const Color.fromRGBO(245, 245, 245, 0.70)),
                      child: Center(
                          child: Text(
                        '我要招人',
                        style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(20),
                            color: const Color.fromRGBO(0, 122, 255, 1)),
                      )),
                    ),
                  ),
                  Container(
                    key: const ValueKey('set Log Off'),
                    height: ScreenAdapter.height(61),
                    color: const Color.fromRGBO(245, 245, 245, 0.70),
                    child: InkWell(
                      onTap: () async {
                        final LoginController loginController =
                            Get.put(LoginController());
                        String ticket = await Storage.getData("ticket") ?? '';

                        MessageModel message =
                            await loginController.setLogOff(ticket);
                        if (message.result == 'success') {
                          Get.back();
                          Get.snackbar("", '登出成功',
                              padding: EdgeInsets.fromLTRB(
                                  ScreenAdapter.width(16),
                                  ScreenAdapter.height(0),
                                  ScreenAdapter.width(16),
                                  ScreenAdapter.height(18)));
                          Get.offAndToNamed('/verify-phone');
                        } else {
                          Get.back();
                          Get.snackbar("", message.message,
                              padding: EdgeInsets.fromLTRB(
                                  ScreenAdapter.width(16),
                                  ScreenAdapter.height(0),
                                  ScreenAdapter.width(16),
                                  ScreenAdapter.height(18)));
                        }
                      },
                      child: Center(
                          child: Text(
                        '退出登录',
                        style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(20),
                            color: const Color.fromRGBO(234, 0, 0, 1)),
                      )),
                    ),
                  ),
                ],
              )),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                margin: EdgeInsets.only(
                  top: ScreenAdapter.height(8),
                ),
                height: ScreenAdapter.height(61),
                child: Center(
                    child: Text(
                  '取消',
                  style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(20),
                      color: const Color.fromRGBO(0, 122, 255, 1)),
                ))),
          )
        ],
      ),
    ));
  }
}
