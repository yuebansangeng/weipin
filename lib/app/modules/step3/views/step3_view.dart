import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/Search1.dart';
import '../../../../widget/floatButton.dart';
import '../controllers/step3_controller.dart';

import '../../../services/screenAdapter.dart';

import '../../../../widget/progress.dart';
import '../../../../widget/radio.dart';
import '../../../../widget/datepicker.dart';
import '../../../../widget/Search.dart';
import '../../../../widget/button.dart';
import '../../../../widget/circleButton.dart';

class Step3View extends GetView<Step3Controller> {
  Step3View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Obx(() => Padding(
            padding: EdgeInsets.fromLTRB(
                ScreenAdapter.width(20),
                ScreenAdapter.height(0),
                ScreenAdapter.width(20),
                ScreenAdapter.height(0)),
            child: controller.currentPart.value != 1 &&
                    controller.currentPart.value != 2
                ? ListView(
                    children: [
                      ...[
                        ProgressLine(
                            currentIndex: controller.currentIndex.value)
                      ],
                      ...(controller.currentPart.value == 0
                          ? part_1()
                          : part_4()),
                      NextButton()
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        ProgressLine(
                            currentIndex: controller.currentIndex.value),
                        ...(controller.currentPart.value == 1
                            ? part_2()
                            : part_3()),
                      ]))));
  }

  List<Widget> part_1() {
    return [
      Text(
        "你的学历是",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ScreenAdapter.fontSize(18),
            color: const Color.fromRGBO(61, 61, 61, 1)),
      ),
      SizedBox(height: ScreenAdapter.height(16)),
      RadioButton(
          selectIndex: controller.qualificationsId.value,
          list: const ['初中及以下', '高中', '中专/中技', '大专', '本科', '硕士', '博士'],
          onChange: (id, value) {
            controller.setDegree(id, value);
          }),
      controller.qualificationsId.value == 4 ||
              controller.qualificationsId.value == 5 ||
              controller.qualificationsId.value == 6
          ? Text(
              "类型",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenAdapter.fontSize(18),
                  color: const Color.fromRGBO(61, 61, 61, 1)),
            )
          : const Text(''),
      SizedBox(height: ScreenAdapter.height(16)),
      controller.qualificationsId.value == 4 ||
              controller.qualificationsId.value == 5 ||
              controller.qualificationsId.value == 6
          ? RadioButton(
              selectIndex: controller.qualificationsType.value,
              list: const ['全日制', '非全日制'],
              onChange: (id, value) {
                // controller.qualificationsType.value = value;
                controller.setType(id);
              })
          : const Text(''),
      controller.qualificationsId.value == 4 ||
              controller.qualificationsId.value == 5 ||
              controller.qualificationsId.value == 6
          ? SizedBox(height: ScreenAdapter.height(113))
          : SizedBox(height: ScreenAdapter.height(167)),
    ];
  }

  List<Widget> part_2() {
    return [
      Text(
        "你毕业于",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ScreenAdapter.fontSize(18),
            color: const Color.fromRGBO(61, 61, 61, 1)),
      ),
      SizedBox(height: ScreenAdapter.height(16)),
      Search1(
          key: const ValueKey('search school'),
          formKey: controller.formKey,
          validator: (v) {
            var exp = new RegExp(r"[\u4e00-\u9fa5]");
            if (v != null) {
              if (exp.hasMatch(v ?? "")) {
                return (v.length > 35 || v.length < 1)
                    ? "字数限制为35个汉字，英文100个字母"
                    : null;
              } else {
                return (v.length > 100 || v.length < 1)
                    ? "字数限制为35个汉字，英文100个字母"
                    : null;
              }
            }
          },
          value: controller.schoolName.value,
          onChange: (value) {
            controller.searchText.value = value;
            controller.setSchoolName(value);
            controller.getSearchSchoolList(value);
          },
          onSubmit: (value) {
            controller.toNext();
          },
          onFoucs: (value) {
            controller.setFocus(value);
          }),
      SizedBox(height: ScreenAdapter.height(10)),
      Expanded(
          flex: 1,
          child: controller.searchText.value != ""
              ? Padding(
                  padding: EdgeInsets.only(left: ScreenAdapter.width(10)),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.searchList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.searchText.value =
                                controller.searchList[index]["schoolName"];
                            controller.setSchoolName(
                                controller.searchList[index]["schoolName"]);
                            controller.toNext();
                          },
                          child: Container(
                            width: double.infinity,
                            height: ScreenAdapter.height(44),
                            padding: EdgeInsets.only(
                              top: ScreenAdapter.height(12),
                              bottom: ScreenAdapter.height(12),
                            ),
                            child: Text(
                              '${controller.searchList[index]["schoolName"]}',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(14)),
                            ),
                          ),
                        );
                      }),
                )
              : const Text('')),
      FloatButton(
          width: 44,
          valueKey: 'step2 circle school button',
          disable: controller.schoolName.value == "",
          onClick: () {
            if ((controller.formKey.currentState as FormState).validate()) {
              controller.toNext();
            }
          },
          hasFocus: controller.hasFocus.value)
    ];
  }

  List<Widget> part_3() {
    return [
      Text(
        "你的专业是",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ScreenAdapter.fontSize(18),
            color: const Color.fromRGBO(61, 61, 61, 1)),
      ),
      SizedBox(height: ScreenAdapter.height(16)),
      Search1(
          key: const ValueKey('search major'),
          formKey: controller.formKey_2,
          value: controller.specializedSubject.value,
          validator: (v) {
            var exp = new RegExp(r"[\u4e00-\u9fa5]");
            if (v != null) {
              if (exp.hasMatch(v ?? "")) {
                return (v.length > 55 || v.length < 1)
                    ? "字数限制为55个汉字，英文100个字母"
                    : null;
              } else {
                return (v.length > 100 || v.length < 1)
                    ? "字数限制为55个汉字，英文100个字母"
                    : null;
              }
            }
          },
          onChange: (value) {
            controller.searchSubjectText.value = value;
            controller.setSpecializedSubject(0, value);
            controller.getSearchSpecializedList(value);
          },
          onSubmit: (value) {
            controller.toNext();
          },
          onFoucs: (value) {
            controller.sethasMajorFocus(value);
          }),
      SizedBox(height: ScreenAdapter.height(10)),
      Expanded(
        flex: 1,
        child: controller.searchSubjectText.value != ""
            ? Padding(
                padding: EdgeInsets.only(left: ScreenAdapter.width(10)),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.searchSubjectList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.searchSubjectText.value = controller
                              .searchSubjectList[index]['specializedName'];
                          controller.setSpecializedSubject(
                              controller.searchSubjectList[index]['id'],
                              controller.searchSubjectList[index]
                                  ['specializedName']);
                          controller.toNext();
                        },
                        child: Container(
                          width: double.infinity,
                          height: ScreenAdapter.height(44),
                          padding: EdgeInsets.only(
                            top: ScreenAdapter.height(12),
                            bottom: ScreenAdapter.height(12),
                          ),
                          child: Text(
                            '${controller.searchSubjectList[index]['specializedName']}',
                            style:
                                TextStyle(fontSize: ScreenAdapter.fontSize(14)),
                          ),
                        ),
                      );
                    }),
              )
            : const Text(''),
      ),
      FloatButton(
          width: 44,
          valueKey: 'step2 circle major button',
          disable: controller.specializedSubject.value == "",
          onClick: () {
            if ((controller.formKey_2.currentState as FormState).validate()) {
              controller.toNext();
            }
          },
          hasFocus: controller.hasMajorFocus.value)
    ];
  }

  List<Widget> part_4() {
    return [
      Padding(
        padding: EdgeInsets.only(
          top: ScreenAdapter.height(54),
          bottom: ScreenAdapter.height(80),
        ),
        child: Center(
          child: Image.asset(
            "assets/images/cinfo/data_2.png",
            width: ScreenAdapter.width(80),
            height: ScreenAdapter.height(80),
          ),
        ),
      ),
      Center(
        child: Wrap(children: [
          Text(
            '就读',
            style: TextStyle(
                fontSize: ScreenAdapter.fontSize(18),
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(51, 51, 51, 1)),
          ),
          Text(
            '(${controller.schoolName})',
            style: TextStyle(
                fontSize: ScreenAdapter.fontSize(18),
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(36, 178, 255, 1)),
          ),
          Text(
            '的时间段是',
            style: TextStyle(
                fontSize: ScreenAdapter.fontSize(18),
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(51, 51, 51, 1)),
          ),
        ]),
      ),
      SizedBox(height: ScreenAdapter.height(40)),
      Row(
        children: [
          Expanded(
              flex: 1,
              child: Center(
                  child: Column(children: [
                Text('入学时间',
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(14),
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(102, 102, 102, 1))),
                SizedBox(height: ScreenAdapter.height(16)),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: ScreenAdapter.height(140),
                    minWidth: 0,
                    //宽度尽可能大
                    maxWidth: double.infinity,
                  ),
                  child: DatePicker(
                      date: controller.schoolStartTime.value,
                      minimumYear: DateTime.now().year - 60 + 16,
                      maximumYear: DateTime.now().year,
                      onChanged: (value) {
                        controller.setSchoolStartTime(value);
                      }),
                )
              ]))),
          Expanded(
              flex: 1,
              child: Center(
                  child: Column(children: [
                Text('毕业时间',
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(14),
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(102, 102, 102, 1))),
                SizedBox(height: ScreenAdapter.height(16)),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: ScreenAdapter.height(140),
                    minWidth: 0,
                    //宽度尽可能大
                    maxWidth: double.infinity,
                  ),
                  child: DatePicker(
                      date: controller.schoolEndTime.value,
                      minimumYear: DateTime.now().year - 60 + 16,
                      maximumYear: DateTime.now().year,
                      onChanged: (value) {
                        controller.setSchoolEndTime(value);
                      }),
                )
              ])))
        ],
      ),
      SizedBox(height: ScreenAdapter.height(99)),
    ];
  }

  Widget NextButton([disable]) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenAdapter.height(50)),
      child: Center(
          child: Button(
        width: 191,
        height: 44,
        disable: disable ?? false,
        onClick: () {
          controller.toNext();
        },
        backgroundColor: const Color.fromRGBO(36, 178, 255, 1),
      )),
    );
  }
}
