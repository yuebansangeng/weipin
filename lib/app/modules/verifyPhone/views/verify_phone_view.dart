import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/verify_phone_controller.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/weipinIcon.dart';
import '../../../models/message_model.dart';

class VerifyPhoneView extends GetView<VerifyPhoneController> {
  VerifyPhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          //消除阴影
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: verifyTele(),
        ));
  }

  Widget verifyTele() {
    VerifyPhoneController controller = Get.find();
    return Obx(() =>
        ListView(physics: const NeverScrollableScrollPhysics(), children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                ScreenAdapter.width(20),
                ScreenAdapter.height(8),
                ScreenAdapter.width(20),
                ScreenAdapter.height(0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // const Icon(weipinIcon.back, color: Color.fromRGBO(51, 51, 51, 1)),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(24)),
                  child: Image.asset(
                    "assets/images/login/logo_text.png",
                    width: ScreenAdapter.width(68),
                    height: ScreenAdapter.height(32),
                  ),
                ),
                SizedBox(
                  height: ScreenAdapter.width(74),
                ),
                Text('手机号登录/注册',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenAdapter.fontSize(24),
                        color: const Color.fromRGBO(51, 51, 51, 1))),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenAdapter.width(0),
                      ScreenAdapter.height(32),
                      ScreenAdapter.width(0),
                      ScreenAdapter.height(24)),
                  child: Container(
                      height: ScreenAdapter.height(50),
                      margin: EdgeInsets.only(top: ScreenAdapter.height(32)),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(240, 240, 240, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // Get.toNamed('/area');
                              // tabs.jumpTo(4);
                            },
                            child: Container(
                              alignment: const Alignment(-1, 0),
                              width: ScreenAdapter.width(84),
                              height: ScreenAdapter.height(42),
                              padding: EdgeInsets.only(
                                  left: ScreenAdapter.width(16)),
                              margin:
                              EdgeInsets.only(left: ScreenAdapter.width(4)),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(children: [
                                const Text("+86"),
                                SizedBox(width: ScreenAdapter.width(6)),
                                const Icon(weipinIcon.down),
                              ]),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: ScreenAdapter.width(247),
                            padding:
                            EdgeInsets.only(left: ScreenAdapter.width(24)),
                            child: TextField(
                              controller: controller.editingController,
                              obscureText: false,
                              style: TextStyle(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontSize: ScreenAdapter.fontSize(14)),
                              keyboardType: TextInputType.phone,
                              //默认弹出数字键盘
                              decoration: const InputDecoration(
                                  hintText: "请输入您的手机号码",
                                  border: InputBorder.none //去掉下划线
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                Stack(clipBehavior: Clip.none, children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        activeColor: const Color.fromRGBO(36, 178, 255, 1),
                        value: controller.comfirm.value,
                        onChanged: (value) {
                          controller.setComfirm(value);
                          if (value == true) {
                            controller.changeTipsStatus(false);
                          }
                        },
                        shape: CircleBorder(), //这里就是实现圆形的设置
                      ),
                      InkWell(
                        onTap: () {
                          controller.comfirm.value = !controller.comfirm.value;
                          controller.setComfirm(controller.comfirm.value);
                          if (controller.comfirm.value == true) {
                            controller.changeTipsStatus(false);
                          }
                        },
                        child: Row(children: [
                          Text(
                            "我已阅读并同意",
                            style:
                            TextStyle(fontSize: ScreenAdapter.fontSize(12)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/h5');
                            },
                            child: Text(
                              "《用户协议》",
                              style: TextStyle(
                                  color: const Color.fromRGBO(36, 178, 255, 1),
                                  fontSize: ScreenAdapter.fontSize(12)),
                            ),
                          ),
                          Text("和",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(12))),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/h5');
                            },
                            child: Text(
                              "《隐私协议》",
                              style: TextStyle(
                                  color: const Color.fromRGBO(36, 178, 255, 1),
                                  fontSize: ScreenAdapter.fontSize(12)),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  !controller.tips.value
                      ? const Text("")
                      : Positioned(
                    width: ScreenAdapter.width(173),
                    height: ScreenAdapter.height(58),
                    top: ScreenAdapter.height(35),
                    left: ScreenAdapter.height(12),
                    child: Container(
                        width: ScreenAdapter.width(173),
                        height: ScreenAdapter.height(58),
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdapter.width(28),
                            ScreenAdapter.height(28),
                            ScreenAdapter.width(10),
                            ScreenAdapter.height(12)),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: const ExactAssetImage(
                                'assets/images/login/tips.png'),
                          ),
                        ),
                        child: Text(
                          '登录前请阅读并勾选协议',
                          style: TextStyle(
                              color: const Color.fromRGBO(61, 61, 61, 1),
                              fontSize: ScreenAdapter.fontSize(12)),
                        )),
                    // child: const Text('登录前请阅读并勾选协议')),
                  )
                ]),
                SizedBox(height: ScreenAdapter.height(84)),
                SizedBox(
                    width: ScreenAdapter.width(335),
                    height: ScreenAdapter.height(44),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (!controller.comfirm.value) {
                            return controller.changeTipsStatus(true);
                          } else {
                            if (!GetUtils.isPhoneNumber(
                                controller.editingController.text) ||
                                controller.editingController.text.length !=
                                    11) {
                              Get.snackbar("", "请输入正确的手机号",
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenAdapter.width(16),
                                      ScreenAdapter.height(0),
                                      ScreenAdapter.width(16),
                                      ScreenAdapter.height(18)));
                              return;
                            }

                            MessageModel model =
                            await controller.sendVerificationCode(
                                controller.editingController.text);
                            if (model.result == 'success') {
                              controller.phone.value =
                                  controller.editingController.text;

                              Get.toNamed('/login',
                                  arguments: {'phone': controller.phone.value});
                            } else {
                              if (controller.phone.value != "") {
                                Get.toNamed('/login', arguments: {
                                  'phone': controller.phone.value
                                });
                              } else {
                                Get.snackbar("", model.message,
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenAdapter.width(16),
                                        ScreenAdapter.height(0),
                                        ScreenAdapter.width(16),
                                        ScreenAdapter.height(18)));
                              }
                            }
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            overlayColor: !controller.comfirm.value
                                ? MaterialStateProperty.all(
                                Color.fromRGBO(182, 230, 255, 1))
                                : MaterialStateProperty.all(Colors.blue),
                            elevation: MaterialStateProperty.all(0),
                            foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                            textStyle: MaterialStateProperty.all(TextStyle(
                                fontSize: ScreenAdapter.height(16),
                                color: Colors.white)),
                            backgroundColor: !controller.comfirm.value
                                ? MaterialStateProperty.all(
                                const Color.fromRGBO(182, 230, 255, 1))
                                : MaterialStateProperty.all(
                                const Color.fromRGBO(36, 178, 255, 1))),
                        child: const Text("下一步")))
              ],
            ),
          )
        ]));
  }
}
