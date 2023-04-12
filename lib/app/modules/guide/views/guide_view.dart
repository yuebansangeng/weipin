import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/weipinIcon.dart';
import '../controllers/guide_controller.dart';
import '../../../services/keepAliveWrapper.dart';
import '../../tabs/controllers/tabs_controller.dart';

class GuideView extends GetView<GuideController> {
  const GuideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
            ),
            backgroundColor: Colors.white,
            body: Obx(
              () => WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: guide(context)),
            )));
  }
}

Widget guide(BuildContext context) {
  @override
  TabsController tabs = Get.put(TabsController());
  final GuideController controller = Get.find();

  //引导页
  BoxDecoration active_button = const BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 1),
      borderRadius: BorderRadius.all(Radius.circular(18)));
  TextStyle active_textStyle = TextStyle(
      fontSize: ScreenAdapter.fontSize(14),
      color: const Color.fromRGBO(11, 169, 255, 1));
  TextStyle textStyle = TextStyle(
      fontSize: ScreenAdapter.fontSize(14),
      color: const Color.fromRGBO(255, 255, 255, 1));
  return Container(
    child: Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: ScreenAdapter.height(190)),
            child: Image.asset(
              "assets/images/login/logo.png",
              width: ScreenAdapter.width(207),
              height: ScreenAdapter.height(58),
            ),
          ),
        ),
        Center(
          child: Container(
              width: ScreenAdapter.width(336),
              margin: EdgeInsets.only(bottom: ScreenAdapter.height(101)),
              padding: EdgeInsets.fromLTRB(
                  ScreenAdapter.width(2),
                  ScreenAdapter.height(2),
                  ScreenAdapter.width(2),
                  ScreenAdapter.height(2)),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(36, 178, 255, 1),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(children: <Widget>[
                Container(
                  decoration: controller.role.value == 0
                      ? active_button
                      : const BoxDecoration(),
                  child: InkWell(
                      child: Container(
                          width: ScreenAdapter.width(166),
                          height: ScreenAdapter.height(56),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(weipinIcon.person,
                                  size: ScreenAdapter.fontSize(16),
                                  color: controller.role.value == 0
                                      ? const Color.fromRGBO(11, 169, 255, 1)
                                      : Colors.white),
                              SizedBox(width: ScreenAdapter.width(5)),
                              Text('我要招人',
                                  style: controller.role.value == 0
                                      ? active_textStyle
                                      : textStyle),
                            ],
                          )),
                      onTap: () {
                        // controller.setRoleType(0);
                        // tabs.jumpToAnimation(1);
                        Get.snackbar("", "暂未开通，敬请期待～",
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdapter.width(16),
                                ScreenAdapter.height(0),
                                ScreenAdapter.width(16),
                                ScreenAdapter.height(18)));
                      }),
                ),
                Container(
                  decoration: controller.role.value == 1
                      ? active_button
                      : const BoxDecoration(),
                  alignment: Alignment.center,
                  width: ScreenAdapter.width(166),
                  height: ScreenAdapter.height(56),
                  child: InkWell(
                      child: Container(
                          width: ScreenAdapter.width(166),
                          height: ScreenAdapter.height(56),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('我要找工作',
                                  style: controller.role.value == 1
                                      ? active_textStyle
                                      : textStyle),
                              SizedBox(width: ScreenAdapter.width(5)),
                              Icon(weipinIcon.search,
                                  size: ScreenAdapter.fontSize(16),
                                  color: controller.role.value == 1
                                      ? const Color.fromRGBO(11, 169, 255, 1)
                                      : Colors.white),
                            ],
                          )),
                      onTap: () {
                        controller.setRoleType(1);
                        // tabs.jumpToAnimation(1);
                        Get.toNamed('/verify-phone');
                      }),
                )
              ])),
        )
      ],
    ),
  );
}
