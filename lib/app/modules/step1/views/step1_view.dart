import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../controllers/step1_controller.dart';
import '../../../services/screenAdapter.dart';
import '../../../../widget/datepicker.dart';
import '../../../../widget/radio.dart';
import '../../../../widget/button.dart';

class Step1View extends GetView<Step1Controller> {
  const Step1View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(20),
              ScreenAdapter.height(0),
              ScreenAdapter.width(20),
              ScreenAdapter.height(0)),
          child: ListView(children: [
            SizedBox(
              height: ScreenAdapter.height(12),
            ),
            Step_1(),
            SizedBox(height: ScreenAdapter.height(40)),
            Padding(
              padding: EdgeInsets.only(bottom: ScreenAdapter.height(50)),
              child: Center(
                  child: Button(
                disable: controller.realName.value == "",
                width: 191,
                height: 44,
                onClick: () {
                  if ((controller.formKey.currentState as FormState)
                      .validate()) {
                    //验证通过提交数据
                    controller.toNext();
                  }
                },
                backgroundColor: const Color.fromRGBO(36, 178, 255, 1),
              )),
            )
          ]),
        )));
  }

  Widget Step_1() {
    final Step1Controller controller = Get.put(Step1Controller());

    return Form(
      key: controller.formKey, //设置globalKey，用于后面获取FormState
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: () {
        if (controller.realName.value == '') {
          controller.setDisalbe(true);
        } else {
          controller.setDisalbe(false);
        }
      },
      child: Column(
        children: [
          Text(
            "现邀请你填入信息生成在线简历,大约用时3分钟~",
            style: TextStyle(
                fontSize: ScreenAdapter.fontSize(20),
                color: const Color.fromRGBO(61, 61, 61, 1)),
          ),
          SizedBox(height: ScreenAdapter.height(24)),
          Row(children: [
            Expanded(
                flex: 0,
                child: Image.asset(
                  "assets/images/cinfo/resume.png",
                  width: ScreenAdapter.width(50),
                  height: ScreenAdapter.height(50),
                )),
            SizedBox(width: ScreenAdapter.width(10)),
            Expanded(
              flex: 1,
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  Text(
                    "在线简历是你与HR在未沟通前的唯一桥梁，完善优质的在线简历，会提高HR与你沟通的概率~",
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(12),
                        color: const Color.fromRGBO(61, 61, 61, 1)),
                  ),
                  SizedBox(height: ScreenAdapter.height(8)),
                  Text(
                    "放心，你的简历我们会妥善保护。",
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(12),
                        color: const Color.fromRGBO(61, 61, 61, 1)),
                  ),
                ],
              ),
            ),
          ]),
          SizedBox(height: ScreenAdapter.height(40)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
                flex: 0,
                child: Image.asset(
                  "assets/images/cinfo/name.png",
                  width: ScreenAdapter.width(50),
                  height: ScreenAdapter.height(50),
                )),
            SizedBox(width: ScreenAdapter.width(10)),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "你的姓名",
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(18),
                        color: const Color.fromRGBO(61, 61, 61, 1)),
                  ),
                  SizedBox(height: ScreenAdapter.height(16)),
                  SizedBox(
                    width: ScreenAdapter.width(275),
                    child: TextFormField(
                        obscureText: false,
                        validator: (v) {
                          var exp = new RegExp(r"[\u4e00-\u9fa5]");
                          if (v != null) {
                            if (exp.hasMatch(v ?? "")) {
                              return (v.length < 13 && v.length > 1)
                                  ? null
                                  : "姓名应为 2-12 个汉字，或 4-24 个字母";
                            } else {
                              return (v.length < 25 && v.length > 3)
                                  ? null
                                  : "姓名应为 2-12 个汉字，或 4-24 个字母";
                            }
                          }
                        },
                        controller: controller.nameController,
                        style: TextStyle(
                            color: const Color.fromRGBO(51, 51, 51, 1),
                            fontSize: ScreenAdapter.fontSize(14)),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "请输入姓名",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: ScreenAdapter.width(15),
                              horizontal: ScreenAdapter.width(16)),
                          focusedBorder: const OutlineInputBorder(
                            ///设置边框四个角的弧度
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(36, 178, 255, 1)),
                          ),
                          border: OutlineInputBorder(
                            ///设置边框四个角的弧度
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),

                            ///用来配置边框的样式
                            borderSide: BorderSide(
                              ///设置边框的颜色
                              width: ScreenAdapter.height(1),
                            ),
                          ),
                          //去掉下划线
                        ),
                        onChanged: (value) {
                          // controller.nameController.text = value;
                          controller.setRealName(value);
                        }),
                  ),
                ],
              ),
            ),
          ]),
          SizedBox(height: ScreenAdapter.height(40)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
                flex: 0,
                child: Image.asset(
                  "assets/images/cinfo/sex.png",
                  width: ScreenAdapter.width(50),
                  height: ScreenAdapter.height(50),
                )),
            SizedBox(width: ScreenAdapter.width(10)),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "你的性别",
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(18),
                        color: const Color.fromRGBO(61, 61, 61, 1)),
                  ),
                  SizedBox(height: ScreenAdapter.height(16)),
                  RadioButton(
                      selectIndex: controller.sex.value,
                      list: const ['男', '女'],
                      onChange: (id, value) {
                        controller.setSex(id);
                      }),
                ],
              ),
            ),
          ]),
          SizedBox(height: ScreenAdapter.height(32)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
                flex: 0,
                child: Image.asset(
                  "assets/images/cinfo/date.png",
                  width: ScreenAdapter.width(50),
                  height: ScreenAdapter.height(50),
                )),
            SizedBox(width: ScreenAdapter.width(10)),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "出生年月",
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(18),
                        color: const Color.fromRGBO(61, 61, 61, 1)),
                  ),
                  SizedBox(height: ScreenAdapter.height(16)),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 0,
                      maxHeight: double.infinity,
                      minWidth: 0, //宽度尽可能大
                      maxWidth: double.infinity, //最小高度
                    ),
                    child: SizedBox(
                      height: ScreenAdapter.height(106),
                      child: Obx(() => DatePicker(
                          key: const ValueKey('step1 date'),
                          date: controller.birthDay.value,
                          minimumYear: DateTime.now().year - 60,
                          maximumYear: DateTime.now().year,
                          onChanged: (value) {
                            controller.setBirthDay(value);
                          })),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
