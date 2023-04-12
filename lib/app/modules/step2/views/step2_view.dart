import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widget/TextField.dart';
import '../../../../widget/floatButton.dart';
import '../controllers/step2_controller.dart';
import '../../../services/screenAdapter.dart';
import '../../../../widget/radio.dart';
import '../../../../widget/button.dart';
import '../../../../widget/datepicker.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/Search1.dart';
import '../../../../widget/circleButton.dart';

class Step2View extends GetView<Step2Controller> {
  Step2View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<Step2Controller>(
      () => Step2Controller(),
    );
    return Obx(() => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(20),
              ScreenAdapter.height(0),
              ScreenAdapter.width(20),
              ScreenAdapter.height(0)),
          child: (controller.currentPart.value != 1 &&
                  controller.currentPart.value != 2 &&
                  controller.currentPart.value != 4)
              ? ListView(
                  children: [
                    ProgressLine(currentIndex: controller.currentIndex.value),
                    ...(controller.currentPart.value == 0
                        ? part_1()
                        : part_4()),
                    NextButton(false)
                  ],
                )
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ProgressLine(currentIndex: controller.currentIndex.value),
                  ...(controller.currentPart.value == 1
                      ? part_2()
                      : controller.currentPart.value == 2
                          ? part_3()
                          : part_5()),
                ]),
        )));
  }

  List<Widget> part_1() {
    return [
      Text(
        "你的身份",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ScreenAdapter.fontSize(18),
            color: const Color.fromRGBO(61, 61, 61, 1)),
      ),
      SizedBox(height: ScreenAdapter.height(16)),
      RadioButton(
          selectIndex: controller.identity.value,
          list: const ['职场人'],
          onChange: (id, value) {
            controller.setIdentity(id);
          }),
      SizedBox(height: ScreenAdapter.height(32)),
      Text(
        "求职状态",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ScreenAdapter.fontSize(18),
            color: const Color.fromRGBO(61, 61, 61, 1)),
      ),
      SizedBox(height: ScreenAdapter.height(16)),
      RadioButton(
          selectIndex: controller.jobStatusId.value,
          list: const ['离职-随时到岗', '在职-月内到岗', '在职-考虑机会', '在职-暂不考虑'],
          onChange: (id, value) {
            controller.setJobStatus(id, value);
          }),
      SizedBox(height: ScreenAdapter.height(32)),
      Text(
        "你首次参加工作的时间",
        style: TextStyle(
            fontWeight: FontWeight.w600,
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
        child: Container(
          height: ScreenAdapter.height(106),
          child: Container(
            child: Obx(() => DatePicker(
                date: controller.firstWorkingTime.value,
                minimumYear: DateTime.now().year - 60 + 16,
                maximumYear: DateTime.now().year,
                onChanged: (value) {
                  controller.setFirstWorkingTime(value);
                })),
          ),
        ),
      ),
      SizedBox(height: ScreenAdapter.height(59)),
    ];
  }

  List<Widget> part_2() {
    return [
      Text(
        "你最近的一份工作是",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ScreenAdapter.fontSize(18),
            color: const Color.fromRGBO(61, 61, 61, 1)),
      ),
      SizedBox(height: ScreenAdapter.height(16)),
      Search1(
          key: const ValueKey('search job'),
          value: controller.positionName.value,
          onChange: (value) {
            controller.hasSelect.value = false;
            controller.searchText.value = value;
            // controller.setPositionId(0, value);
            controller.getSearchPositionList(value);
          },
          onSubmit: (value) {
            // controller.toNext();
          },
          onFoucs: (value) {
            controller.setFocus(value);
          }),
      SizedBox(height: ScreenAdapter.height(16)),
      Expanded(
        flex: 1,
        child: Container(
            padding: EdgeInsets.only(
              left: ScreenAdapter.width(10),
            ),
            child: controller.searchText.value != "" &&
                    !controller.hasSelect.value
                ? ListView.builder(
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    itemCount: controller.searchPositionList.length,
                    itemBuilder: (context, index) {
                      // var _index = controller.searchPositionList[index]
                      //     .toLowerCase()
                      //     .indexOf(controller.searchText.value.toLowerCase());
                      // print(_index);
                      // var high_light = '';
                      // var left = '';
                      // var right = '';
                      //
                      // if (_index == -1) {
                      //   high_light = '';
                      //   left = controller.searchPositionList[index];
                      //   right = '';
                      // } else {
                      //   high_light = controller.searchPositionList[index]
                      //       .substring(_index,
                      //           _index + controller.searchText.value.length);
                      //   left = controller.searchPositionList[index]
                      //       .substring(0, _index);
                      //   right = controller.searchPositionList[index].substring(
                      //       _index + controller.searchText.value.length);
                      // }
                      var name = controller.searchPositionList[index]['name'];
                      var parentNameTwo =
                          controller.searchPositionList[index]['parentNameTwo'];
                      var parentNameOne =
                          controller.searchPositionList[index]['parentNameOne'];

                      return InkWell(
                          onTap: () {
                            int id = controller.searchPositionList[index]
                                ['positionId'];
                            controller.setPositionId(
                                id,
                                name +
                                    '-' +
                                    parentNameTwo +
                                    '-' +
                                    parentNameOne);
                            controller.searchText.value = name +
                                '-' +
                                parentNameTwo +
                                '-' +
                                parentNameOne;
                            controller.hasSelect.value = true;
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
                                  "${name}-${parentNameTwo}-${parentNameOne}")));
                    })
                : controller.positionList.length != 0
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Expanded(
                                flex: 1,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.positionList.length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: ScreenAdapter.height(32),
                                            right: ScreenAdapter.width(16)),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.setSelectIndex(index);
                                          },
                                          child: Text(
                                              controller.positionList[index]
                                                  ['name'],
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.fontSize(
                                                          14),
                                                  color: controller.selectIndex
                                                              .value ==
                                                          index
                                                      ? const Color.fromRGBO(
                                                          36, 178, 255, 1)
                                                      : const Color.fromRGBO(
                                                          102, 102, 102, 1))),
                                        ),
                                      );
                                    })),
                            Expanded(
                              flex: 3,
                              child: Container(
                                  padding: EdgeInsets.only(
                                    left: ScreenAdapter.width(16),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                    left: BorderSide(
                                        width: ScreenAdapter.height(2),
                                        color:
                                            Color.fromRGBO(249, 249, 249, 1)),
                                  )),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: controller
                                          .positionList[controller
                                              .selectIndex.value]['children']
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: ScreenAdapter.height(16),
                                                bottom:
                                                    ScreenAdapter.height(16),
                                              ),
                                              child: Text(
                                                '${controller.positionList[controller.selectIndex.value]['children'][index]['name']}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            16)),
                                              ),
                                            ),
                                            GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: (controller
                                                                    .positionList[
                                                                controller
                                                                    .selectIndex
                                                                    .value]
                                                            ['children'][index]
                                                        ['children'] as List)
                                                    .length,
                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing:
                                                        ScreenAdapter.width(11),
                                                    mainAxisSpacing:
                                                        ScreenAdapter.height(
                                                            12),
                                                    childAspectRatio: 110 / 34),
                                                itemBuilder: ((context, i) {
                                                  List list =
                                                      controller.positionList[
                                                                  controller
                                                                      .selectIndex
                                                                      .value][
                                                              'children'][index]
                                                          ['children'] as List;
                                                  return InkWell(
                                                    onTap: () {
                                                      int id =
                                                          list[i]['positionId'];
                                                      controller.hasSelect
                                                          .value = true;
                                                      controller.setPositionId(
                                                          id, list[i]['name']);
                                                      controller.searchText
                                                              .value =
                                                          list[i]['name'];
                                                      controller.toNext();
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      249,
                                                                      249,
                                                                      249,
                                                                      1)),
                                                      child: Center(
                                                          child: Text(
                                                              '${list[i]['name']}')),
                                                    ),
                                                  );
                                                }))
                                          ],
                                        );
                                      })),
                            ),
                          ])
                    : const SizedBox()),
      ),
      FloatButton(
          width: 44,
          valueKey: 'step2 circle  talent button',
          disable: controller.hasSelect.value == false,
          onClick: () {
            controller.setFocus(false);
            controller.toNext();
          },
          hasFocus: controller.hasFocus.value)
    ];
  }

  List<Widget> part_3() {
    return [
      Text(
        "你最近就职的公司是",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ScreenAdapter.fontSize(18),
            color: const Color.fromRGBO(61, 61, 61, 1)),
      ),
      Padding(
        padding: EdgeInsets.only(top: ScreenAdapter.height(8)),
        child: Text(
          "我们会自动屏蔽该公司，HR无法看到你的信息，后期可以自行修改～",
          style: TextStyle(
              fontSize: ScreenAdapter.fontSize(12),
              color: const Color.fromRGBO(102, 102, 102, 1)),
        ),
      ),
      SizedBox(height: ScreenAdapter.height(16)),
      Expanded(
        flex: 1,
        child: Search1(
            key: const ValueKey('recentlyCompany'),
            formKey: controller.formKey,
            value: controller.recentlyCompany.value,
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
              controller.setRecentlyCompany(value);
            },
            onSubmit: (value) {
              if ((controller.formKey.currentState as FormState).validate()) {
                controller.setCompanyFocus(false);
                controller.toNext();
              }
            },
            onFoucs: (value) {
              controller.setCompanyFocus(value);
            }),
      ),
      FloatButton(
          width: 44,
          valueKey: 'step2 circle  company button',
          disable: controller.recentlyCompany.value == "",
          onClick: () {
            if ((controller.formKey.currentState as FormState).validate()) {
              controller.setCompanyFocus(false);
              controller.toNext();
            }
          },
          hasFocus: controller.hasCompanyFocus.value)
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
        child: Text(
          '在这个公司入职的时间段是',
          style: TextStyle(
              fontSize: ScreenAdapter.fontSize(18),
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(51, 51, 51, 1)),
        ),
      ),
      SizedBox(height: ScreenAdapter.height(40)),
      Row(
        children: [
          Expanded(
              flex: 1,
              child: Center(
                  child: Column(children: [
                Text('入职时间',
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
                      date: controller.recentlyCompanyStartTime.value,
                      minimumYear: DateTime.now().year - 60 + 16,
                      maximumYear: DateTime.now().year,
                      onChanged: (value) {
                        controller.setRecentlyCompanyStartTime(value);
                      }),
                )
              ]))),
          Expanded(
              flex: 1,
              child: Center(
                  child: Column(children: [
                Text('离职时间',
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
                      date: controller.recentlyCompanyEndTime.value,
                      minimumYear: DateTime.now().year - 60 + 16,
                      maximumYear: DateTime.now().year,
                      onChanged: (value) {
                        controller.setRecentlyCompanyEndTime(value);
                      }),
                )
              ])))
        ],
      ),
      SizedBox(height: ScreenAdapter.height(99)),
    ];
  }

  List<Widget> part_5() {
    return [
      Text('请简单介绍一下工作内容',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ScreenAdapter.fontSize(18),
              color: Color.fromRGBO(51, 51, 51, 1))),
      Padding(
          padding: EdgeInsets.only(
            top: ScreenAdapter.height(8),
            bottom: ScreenAdapter.height(24),
          ),
          child: Text('描述这段工作的内容、负责的业务、取得的成果',
              style: TextStyle(
                  fontSize: ScreenAdapter.fontSize(12),
                  color: Color.fromRGBO(102, 102, 102, 1)))),
      Expanded(
          flex: 5,
          child: TextFieldWeipin(
            key: ValueKey('job content'),
            formKey: controller.formKey_2,
            value: controller.jobContent.value,
            hintText: '"说说你在XX公司的工作内容\n清晰具体的描述会有更多HR关注到你～"',
            validator: (v) {
              var exp = new RegExp(r"[\u4e00-\u9fa5]");
              if (v != null) {
                if (exp.hasMatch(v ?? "")) {
                  //是汉字
                  if (v.length > 500) {
                    return "字数限制为5-500个汉字，10-1000个字母";
                  } else if (v.length < 5) {
                    return "至少输入 5 个汉字或 10 个字母";
                  }
                  return null;
                } else {
                  //不是汉字
                  if (v.length > 1000) {
                    return "字数限制为5-500个汉字，10-1000个字母";
                  } else if (v.length < 10) {
                    return "至少输入 5 个汉字或 10 个字母";
                  }
                  return null;
                }
              }
            },
            onChange: (value) {
              controller.setJobContent(value);
            },
            onFocus: (value) {
              controller.setFocus(value);
            },
            onSubmit: (value) {
              if ((controller.formKey_2.currentState as FormState).validate()) {
                controller.toNext();
              }
            },
          )),
      Expanded(flex: 1, child: SizedBox(height: ScreenAdapter.height(1))),
      FloatButton(
          width: 44,
          valueKey: 'step2 circle jobContent button',
          disable: controller.jobContent.value == "",
          onClick: () {
            if ((controller.formKey_2.currentState as FormState).validate()) {
              controller.toNext();
            }
          },
          hasFocus: controller.hasFocus.value)
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
