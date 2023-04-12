import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widget/Search1.dart';
import '../../../../widget/button.dart';
import '../../../../widget/circleButton.dart';
import '../../../../widget/more.dart';
import '../../../services/screenAdapter.dart';

import '../controllers/city_controller.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/Search.dart';

class CityView extends GetView<CityController> {
  const CityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => More(
          showBackBtn: true,
          onTabClik: () {
            Get.back();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenAdapter.width(20),
                  ScreenAdapter.height(0),
                  ScreenAdapter.width(20),
                  ScreenAdapter.height(0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProgressLine(currentIndex: controller.currentIndex.value),
                  Text(
                    "你理想的工作城市是",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenAdapter.fontSize(18),
                        color: const Color.fromRGBO(61, 61, 61, 1)),
                  ),
                  SizedBox(height: ScreenAdapter.height(16)),
                  Search1(
                      key: const ValueKey('search city'),
                      value: controller.searchText.value,
                      onChange: (value) {
                        controller.searchText.value = value;
                        controller.getSearchLocationList(value);
                      },
                      onSubmit: (value) {
                        controller.toNext('0', controller.searchText.value);
                      },
                      onFoucs: (value) {
                        controller.setFocus(value);
                      }),
                  Expanded(
                      flex: 1,
                      child: controller.searchText.value == ""
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenAdapter.width(10)),
                              child: ListView.builder(
                                  itemCount: controller.provinceList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: ScreenAdapter.height(16),
                                            bottom: ScreenAdapter.height(16),
                                          ),
                                          child: Text(
                                              '${controller.provinceList[index]['firstLetter']}',
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      1, 61, 61, 1),
                                                  fontSize:
                                                      ScreenAdapter.fontSize(
                                                          16),
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: controller
                                                .provinceList[index]
                                                    ['provinceList']
                                                .length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing:
                                                        ScreenAdapter.width(8),
                                                    mainAxisSpacing:
                                                        ScreenAdapter.height(8),
                                                    childAspectRatio: 100 / 34),
                                            itemBuilder: ((context, i) {
                                              List list =
                                                  controller.provinceList[index]
                                                      ['provinceList'];
                                              return InkWell(
                                                onTap: () {
                                                  String id =
                                                      list[i]['id'].toString();
                                                  String value =
                                                      list[i]['text'];
                                                  controller.toNext(id, value);
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              249,
                                                              249,
                                                              249,
                                                              1)),
                                                  child: Center(
                                                      child: Text(
                                                          '${list[i]['text']}')),
                                                ),
                                              );
                                            }))
                                      ],
                                    );
                                  }))
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenAdapter.width(10)),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.searchProvinceList.length,
                                  itemBuilder: (context, index) {
                                    String current =
                                        "${controller.searchProvinceList[index]['text']}";
                                    return InkWell(
                                      onTap: () {
                                        String id = controller
                                            .searchProvinceList[index]['id']
                                            .toString();
                                        controller.toNext(id, current);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: ScreenAdapter.height(44),
                                        padding: EdgeInsets.only(
                                          top: ScreenAdapter.height(12),
                                          bottom: ScreenAdapter.height(12),
                                        ),
                                        child: Text(
                                          '${current}',
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(14)),
                                        ),
                                      ),
                                    );
                                  }),
                            )),
                  // controller.hasFocus.value
                  //     ? CircleButton(
                  //         width: 44,
                  //         height: 44,
                  //         disable: controller.searchText.value == "",
                  //         onClick: () {
                  //           controller.toNext('0', controller.searchText.value);
                  //         },
                  //       )
                  //     : Padding(
                  //         padding:
                  //             EdgeInsets.only(bottom: ScreenAdapter.height(50)),
                  //         child: NextButton(controller.searchText.value == ""))
                ],
              ),
            ),
          ),
        ));
  }

  Widget NextButton([disable]) {
    return Center(
        child: Button(
      width: 191,
      height: 44,
      disable: disable ?? false,
      onClick: () {
        controller.toNext('0', controller.searchText.value);
      },
      backgroundColor: const Color.fromRGBO(36, 178, 255, 1),
    ));
  }
}
