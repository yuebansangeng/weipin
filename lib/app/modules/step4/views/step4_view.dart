import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../../../../widget/circleButton.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/weipinIcon.dart';

import '../../cinfo/controllers/cinfo_controller.dart';
import '../controllers/step4_controller.dart';

import '../../../../widget/progress.dart';
import '../../../../widget/button.dart';

class Step4View extends GetView<Step4Controller> {
  Step4View({Key? key}) : super(key: key);

  Step4Controller controller = Get.put(Step4Controller());
  FocusNode focusNode1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    focusNode1.addListener(() {
      controller.hasFocus.value = focusNode1.hasFocus;
    });
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenAdapter.width(20),
                  ScreenAdapter.height(0),
                  ScreenAdapter.width(20),
                  ScreenAdapter.height(0)),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProgressLine(currentIndex: controller.currentIndex.value),
                      ...((controller.currentPart.value == 0
                          ? firstStep(context)
                          : secondStep())),
                    ] //secondStep()
                    ),
              ),
            )));
  }

  List<Widget> firstStep(BuildContext context) {
    return [
      Text(
        "希望找什么工作",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ScreenAdapter.fontSize(18),
            color: const Color.fromRGBO(61, 61, 61, 1)),
      ),
      Padding(
        padding: EdgeInsets.only(
            top: ScreenAdapter.height(24), bottom: ScreenAdapter.height(16)),
        child: Text(
          "你理想的工作城市是",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ScreenAdapter.fontSize(16),
              color: const Color.fromRGBO(51, 51, 51, 1)),
        ),
      ),
      SizedBox(
        width: ScreenAdapter.width(335),
        child: TextFormField(
          obscureText: false,
          style: TextStyle(
              color: const Color.fromRGBO(51, 51, 51, 1),
              fontSize: ScreenAdapter.fontSize(14)),
          controller: controller.cityEditController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: "请输入城市",
            focusedBorder: const OutlineInputBorder(
              ///设置边框四个角的弧度
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Color.fromRGBO(36, 178, 255, 1)),
            ),
            border: OutlineInputBorder(
              ///设置边框四个角的弧度
              borderRadius: const BorderRadius.all(Radius.circular(10)),

              ///用来配置边框的样式
              borderSide: BorderSide(
                ///设置边框的颜色
                width: ScreenAdapter.height(1),
              ),
            ), //去掉下划线
          ),
          onTap: () {
            Get.toNamed('/city');
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            top: ScreenAdapter.height(24), bottom: ScreenAdapter.height(16)),
        child: Text(
          "你期望的职位是",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ScreenAdapter.fontSize(16),
              color: const Color.fromRGBO(51, 51, 51, 1)),
        ),
      ),
      SizedBox(
        width: ScreenAdapter.width(335),
        child: TextFormField(
          obscureText: false,
          controller: controller.positionEditController,
          style: TextStyle(
              color: const Color.fromRGBO(51, 51, 51, 1),
              fontSize: ScreenAdapter.fontSize(14)),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: "请输入职位",
            focusedBorder: const OutlineInputBorder(
              ///设置边框四个角的弧度
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Color.fromRGBO(36, 178, 255, 1)),
            ),
            border: OutlineInputBorder(
              ///设置边框四个角的弧度
              borderRadius: const BorderRadius.all(Radius.circular(10)),

              ///用来配置边框的样式
              borderSide: BorderSide(
                ///设置边框的颜色
                width: ScreenAdapter.height(1),
              ),
            ), //去掉下划线
          ),
          onTap: () {
            Get.toNamed('/position');
          },
        ),
      ),
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: ScreenAdapter.height(24),
                bottom: ScreenAdapter.height(32)),
            child: Text(
              "你期望的薪资是",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenAdapter.fontSize(16),
                  color: const Color.fromRGBO(51, 51, 51, 1)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenAdapter.width(16)),
            child: Text(
              " 单位:千元 1K代表1000元",
              style: TextStyle(
                  fontSize: ScreenAdapter.fontSize(12),
                  color: const Color.fromRGBO(153, 153, 153, 1)),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
              flex: 1,
              child: Center(
                  child: Column(children: [
                Text('最低薪资',
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(14),
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(102, 102, 102, 1))),
                SizedBox(height: ScreenAdapter.height(31)),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: ScreenAdapter.height(130),
                    minWidth: 0,
                    //宽度尽可能大
                    maxWidth: double.infinity,
                  ),
                  child: CupertinoPicker(
                    key: UniqueKey(),
                    scrollController: controller.hopeLowSalaryPicker,
                    backgroundColor:
                        CupertinoColors.systemBackground.resolveFrom(context),
                    itemExtent: 32.0,
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    // This is called when selected item is changed.
                    onSelectedItemChanged: (selectedItem) {
                      controller.setHopeLowSalary(selectedItem + 1);
                    },
                    children: List<Widget>.generate(250, (index) {
                      return Center(
                        child: Text('${index + 1}k'),
                      );
                    }),
                  ),
                )
              ]))),
          Expanded(
              flex: 1,
              child: Center(
                  child: Column(children: [
                Text('最高薪资',
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(14),
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(102, 102, 102, 1))),
                SizedBox(height: ScreenAdapter.height(31)),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: ScreenAdapter.height(130),
                    minWidth: 0,
                    //宽度尽可能大
                    maxWidth: double.infinity,
                  ),
                  child: CupertinoPicker(
                    scrollController: controller.hopeHighSalaryPicker,
                    backgroundColor:
                        CupertinoColors.systemBackground.resolveFrom(context),
                    itemExtent: 32.0,
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    // This is called when selected item is changed.
                    onSelectedItemChanged: (selectedItem) {
                      controller.setHopeHighSalary(selectedItem + 1);
                    },
                    children: List<Widget>.generate(250, (index) {
                      return Center(
                        child: Text('${index + 1}k'),
                      );
                    }),
                  ),
                )
              ]))),
        ],
      ),
      SizedBox(
        height: ScreenAdapter.height(35),
      ),
      NextButton(controller.locationName.value == "" ||
          controller.hopePositionName.value == "")
    ];
  }

  List<Widget> secondStep() {
    return [
      Text('分享你的个人优势',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ScreenAdapter.fontSize(18),
              color: const Color.fromRGBO(51, 51, 51, 1))),
      Padding(
          padding: EdgeInsets.only(
            top: ScreenAdapter.height(8),
            bottom: ScreenAdapter.height(24),
          ),
          child: Text('几句话说出你的优势，让HR主动找你~',
              style: TextStyle(
                  fontSize: ScreenAdapter.fontSize(12),
                  color: const Color.fromRGBO(102, 102, 102, 1)))),
      Form(
        key: controller.formKey,
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: controller.personController,
          focusNode: focusNode1,
          key: ValueKey('share advantage'),
          validator: (v) {
            var exp = new RegExp(r"[\u4e00-\u9fa5]");
            if (v != null) {
              if (exp.hasMatch(v ?? "")) {
                //是汉字
                if (v.length > 200) {
                  return "字数限制为5-200个汉字，10-500个字母";
                } else if (v.length < 5) {
                  return "至少输入 5 个汉字或 10 个字母";
                }
                return null;
              } else {
                //不是汉字
                if (v.length > 500) {
                  return "字数限制为5-200个汉字，10-500个字母";
                } else if (v.length < 10) {
                  return "至少输入 5 个汉字或 10 个字母";
                }
                return null;
              }
            }
          },
          onChanged: (value) {
            controller.setPersonalAdvantage(value);
          },
          onFieldSubmitted: (value) {
            if ((controller.formKey.currentState as FormState).validate()) {
              controller.toNext();
            }
          },
          style: TextStyle(
              fontSize: ScreenAdapter.fontSize(14),
              color: const Color.fromRGBO(51, 51, 51, 1)),
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromRGBO(249, 249, 249, 1),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none),
              hintText: "用1~2句话向HR介绍你自己",
              hintStyle: TextStyle(height: 1.5)),
          maxLines: 8,
        ),
      ),
      focusNode1.hasFocus
          ? CircleButton(
              width: 44,
              height: 44,
              disable: controller.personalAdvantage.value == "",
              onClick: () {
                if ((controller.formKey.currentState as FormState).validate()) {
                  controller.toNext();
                }
              },
            )
          : Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(top: ScreenAdapter.height(15)),
              child: GestureDetector(
                  onTap: () {
                    final CInfoController tabs = Get.put(CInfoController());
                    tabs.jumpToAnimation(3);
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Button(
                      width: 161,
                      height: 44,
                      disable: controller.personalAdvantage.value == "",
                      content: '开始找工作',
                      onClick: () {
                        if ((controller.formKey.currentState as FormState)
                            .validate()) {
                          controller.toNext();
                        }
                      },
                      backgroundColor: const Color.fromRGBO(36, 178, 255, 1),
                    ),
                  )))
    ];
  }

  Widget NextButton([disable]) {
    return Center(
        child: Button(
      width: 191,
      height: 44,
      disable: disable ?? false,
      onClick: () {
        controller.toNext();
      },
    ));
  }
}
