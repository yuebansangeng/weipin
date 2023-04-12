import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widget/Search1.dart';
import '../../../../widget/button.dart';
import '../../../../widget/circleButton.dart';
import '../controllers/position_controller.dart';

import '../../../services/screenAdapter.dart';

import '../../../../widget/progress.dart';
import '../../../../widget/Search.dart';

class PositionView extends GetView<PositionController> {
  const PositionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            elevation: 0, //消除阴影
            backgroundColor: Colors.white,
            title: Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
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
            )),
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
                "你期望的职位是",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenAdapter.fontSize(18),
                    color: const Color.fromRGBO(61, 61, 61, 1)),
              ),
              SizedBox(height: ScreenAdapter.height(16)),
              Search1(
                  key: const ValueKey('search position'),
                  value: controller.searchText.value,
                  onChange: (value) {
                    controller.searchText.value = value;
                    controller.getSearchPositionList(value);
                  },
                  onSubmit: (value) {},
                  onFoucs: (value) {
                    controller.setFocus(value);
                  }),
              Expanded(
                  flex: 1,
                  child: controller.searchText.value != ""
                      ? Padding(
                          padding:
                              EdgeInsets.only(left: ScreenAdapter.width(10)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.searchList.length,
                              itemBuilder: (context, index) {
                                String current =
                                    "${controller.searchList[index]['name']}-${controller.searchList[index]['parentNameTwo']}-${controller.searchList[index]['parentNameOne']}";
                                return InkWell(
                                  onTap: () {
                                    int id = int.parse(controller
                                        .searchList[index]['positionId']
                                        .toString());
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
                                          fontSize: ScreenAdapter.fontSize(14)),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : const Text('')),
              // controller.hasFocus.value
              //     ? CircleButton(
              //         width: 44,
              //         height: 44,
              //         disable: controller.searchText.value == "",
              //         onClick: () {
              //           controller.toNext(0, controller.searchText.value);
              //         },
              //       )
              //     : Padding(
              //         padding:
              //             EdgeInsets.only(bottom: ScreenAdapter.height(50)),
              //         child: NextButton(controller.searchText.value == ""))
            ],
          ),
        )));
  }

  show() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      height: ScreenAdapter.height(150),
      child: Column(
        children: [const Text('退出登录')],
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
        controller.toNext(0, controller.searchText.value);
      },
    ));
  }
}
