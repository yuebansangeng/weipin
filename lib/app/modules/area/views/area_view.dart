import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';
import '../controllers/area_controller.dart';
import '../../../services/weipinIcon.dart';
import '../../tabs/controllers/tabs_controller.dart';

class AreaView extends GetView<AreaController> {
  const AreaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const area = [
      {
        "name": 'A',
        "list": [
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
        ]
      },
      {
        "name": 'B',
        "list": [
          {
            "title": '巴西',
            "num": '+861',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
        ]
      },
      {
        "name": 'C',
        "list": [
          {
            "title": '成都',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
        ]
      },
      {
        "name": 'D',
        "list": [
          {
            "title": '德国',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
        ]
      },
      {
        "name": 'E',
        "list": [
          {
            "title": '俄罗斯',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
        ]
      },
      {
        "name": 'F',
        "list": [
          {
            "title": '法国',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
          {
            "title": '中国内地',
            "num": '+86',
          },
        ]
      },
    ];
    const letters = ['A', 'B', 'C', 'D', 'E', 'F'];
    @override
    final TabsController tabs = Get.put(TabsController());
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: ScreenAdapter.height(36),
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    top: 0,
                    child: GestureDetector(
                      child: Icon(weipinIcon.back,
                          size: ScreenAdapter.height(36),
                          color: Color.fromRGBO(51, 51, 51, 1)),
                      onTap: () {
                        tabs.setCurrentIndex(1);
                      },
                    )),
                Center(
                    child: Text(
                  '请选择国家或地区',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenAdapter.fontSize(16),
                      color: const Color.fromRGBO(51, 51, 51, 1)),
                ))
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
                itemCount: area.length,
                controller: controller.scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return ListView.builder(
                      itemCount:
                          AreaModuleList.fromJson(area[index]).list?.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index_2) {
                        return Container(
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: ScreenAdapter.height(2),
                                  color: Color.fromRGBO(249, 249, 249, 1)),
                            )),
                            margin: EdgeInsets.fromLTRB(
                                ScreenAdapter.width(20),
                                ScreenAdapter.height(0),
                                ScreenAdapter.width(40),
                                ScreenAdapter.height(0)),
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdapter.width(0),
                                ScreenAdapter.height(24),
                                ScreenAdapter.width(0),
                                ScreenAdapter.height(24)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    '${AreaModuleList.fromJson(area[index]).list?[index_2].title}'),
                                Text(
                                    '${AreaModuleList.fromJson(area[index]).list?[index_2].num}'),
                              ],
                            ));
                      });
                }),
            Positioned(
              height: ScreenAdapter.height(273),
              width: ScreenAdapter.width(20),
              right: 0,
              child: SizedBox(
                child: ListView.builder(
                  itemCount: letters.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Text(
                        letters[index],
                        style: TextStyle(
                          color: Color.fromRGBO(51, 51, 51, 1),
                          fontSize: ScreenAdapter.fontSize(10),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        double height = 0.0;
                        for (int i = 0; i < index; i++) {
                          height += (AreaModuleList.fromJson(area[index - 1])
                                  .list
                                  ?.length)! *
                              72.0;
                        }
                        controller.setScrollHeight(height);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
