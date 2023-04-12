import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/keepAliveWrapper.dart';
import '../../verifyPhone/controllers/verify_phone_controller.dart';
import '../../tabs/controllers/tabs_controller.dart';
import '../../../services/weipinIcon.dart';
import '../../../models/message_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../cinfo/views/cinfo_view.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              //消除阴影
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: verfiCode(context)));
  }

  Widget verfiCode(context) {
    VerifyPhoneController verifyController = Get.find();
    return GetBuilder<LoginController>(
        initState: (state) {
          controller.countDown();
        },
        init: controller,
        builder: (controller) {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
                ScreenAdapter.width(20),
                ScreenAdapter.height(8),
                ScreenAdapter.width(20),
                ScreenAdapter.height(0)),
            children: [
              Column(
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
                  Text('输入验证码',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenAdapter.fontSize(24),
                          color: const Color.fromRGBO(51, 51, 51, 1))),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        ScreenAdapter.width(0),
                        ScreenAdapter.height(13),
                        ScreenAdapter.width(0),
                        ScreenAdapter.height(31)),
                    child: Text('验证码已发送至 ${verifyController.phone.value}',
                        style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(14),
                            color: const Color.fromRGBO(51, 51, 51, 1))),
                  ),
                  Container(
                    child: PinCodeTextField(
                      autoFocus: true,
                      //进入就弹出键盘
                      keyboardType: TextInputType.number,
                      //调用数字键盘
                      length: 6,
                      obscureText: false,
                      enablePinAutofill: true,
                      animationType: AnimationType.fade,
                      cursorColor: Colors.transparent,
                      //光标颜色
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenAdapter.fontSize(24),
                          color: const Color.fromRGBO(51, 51, 51, 1)),
                      dialogConfig: DialogConfig(
                          //汉化dialog
                          dialogTitle: "黏贴验证码",
                          dialogContent: "确定要黏贴验证码",
                          affirmativeText: "确定",
                          negativeText: "取消"),
                      //配置dialog
                      pinTheme: PinTheme(
                        //样式
                        // 修改边框
                        activeColor: const Color.fromRGBO(221, 221, 221, 1),
                        // 输入文字后边框的颜色
                        selectedColor: const Color.fromRGBO(221, 221, 221, 1),
                        // 选中边框的颜色
                        inactiveColor: const Color.fromRGBO(249, 249, 249, 1),
                        //背景颜色
                        activeFillColor: const Color.fromRGBO(249, 249, 249, 1),
                        selectedFillColor:
                            const Color.fromRGBO(249, 249, 249, 1),
                        inactiveFillColor:
                            const Color.fromRGBO(249, 249, 249, 1),
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: ScreenAdapter.height(60),
                        fieldWidth: ScreenAdapter.width(44),
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: controller.editingCodeController,
                      //TextFiled控制器
                      onCompleted: (v) async {
                        // 隐藏键盘
                        FocusScope.of(context).requestFocus(FocusNode());
                        // Get.toNamed('/cinfo');
                        MessageModel model =
                            await controller.regOrLoginByMobileCode({
                          "identity": 1, //todo 角色配置
                          "phone": verifyController.phone.value,
                          "validCode": v
                        });
                        if (model.result == 'success') {
                          controller.setVerifyCode();
                        } else {
                          Get.snackbar("", model.message,
                              padding: EdgeInsets.fromLTRB(
                                  ScreenAdapter.width(16),
                                  ScreenAdapter.height(0),
                                  ScreenAdapter.width(16),
                                  ScreenAdapter.height(18)));
                        }
                      },
                      onChanged: (value) {
                        // print('change${value}');
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                      appContext: context, //注意需要传入context
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: controller.seconds.value == 0
                        ? InkWell(
                            onTap: () async {
                              FocusScope.of(context)
                                  .requestFocus(FocusNode()); //隐藏键盘
                              MessageModel model =
                                  await verifyController.sendVerificationCode(
                                      verifyController.phone.value);
                              if (model.result == 'success') {
                                controller.countDown(); //开始倒计时
                              } else {
                                Get.snackbar("", model.message,
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenAdapter.width(16),
                                        ScreenAdapter.height(0),
                                        ScreenAdapter.width(16),
                                        ScreenAdapter.height(18)));
                              }
                            },
                            child: const Text("重新获取",
                                style: TextStyle(
                                    color: Color.fromRGBO(36, 178, 255, 1))))
                        : Text("${controller.seconds.value}秒",
                            style: const TextStyle(
                                color: Color.fromRGBO(102, 102, 102, 1))),
                  ),
                ],
              )
            ],
          );
        });
  }
}
