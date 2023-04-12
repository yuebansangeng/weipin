import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:weipin/app/services/screenAdapter.dart';
import 'package:weipin/app/services/weipinIcon.dart';

import '../controllers/ccenter_controller.dart';

import './widget/switchbutton.dart';
import './widget/top.dart';

class CcenterView extends GetView<CcenterController> {
  const CcenterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 700,
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(44),
              left: ScreenAdapter.width(20),
              right: ScreenAdapter.height(20)),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter, //右上
                  end: Alignment.bottomCenter, //左下
                  stops: [
                -1.0,
                1.0
              ],
                  colors: [
                Color.fromRGBO(186, 231, 255, 1),
                Color.fromRGBO(186, 231, 255, 0)
              ])),
          child: Stack(children: [
            Positioned(
                top: 0,
                left: 0,
                child: Image.asset('assets/images/home/center.png',
                    width: ScreenAdapter.height(240),
                    height: ScreenAdapter.height(240))),
            SingleChildScrollView(
              child: Column(children: [
                SwicthButton(onLeftClick: () {
                  Get.toNamed('/choose');
                }, onRightClick: () {
                  Get.toNamed('/cconfig');
                }),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenAdapter.height(30),
                      bottom: ScreenAdapter.height(24)),
                  child: TopInfo(
                      avatar: '1',
                      name: '李女士',
                      onClick: () {
                        Get.toNamed('/cresume');
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Text('沟通过'),
                        SizedBox(width: ScreenAdapter.width(20)),
                        Text('999',
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(14),
                                color: Color(0xFF24B2FF)))
                      ],
                    ),
                    Container(
                        width: ScreenAdapter.width(1),
                        height: ScreenAdapter.height(24),
                        color: const Color(0xFF71CDFF)),
                    Row(
                      children: [
                        const Text('看过'),
                        SizedBox(width: ScreenAdapter.width(20)),
                        Text('999',
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(14),
                                color: Color(0xFF24B2FF)))
                      ],
                    )
                  ],
                ),
                SizedBox(height: ScreenAdapter.height(26)),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.only(
                      top: ScreenAdapter.height(9),
                      left: ScreenAdapter.width(20)),
                  child: Container(
                    height: ScreenAdapter.height(142),
                    width: ScreenAdapter.height(335),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('求职服务',
                              style: TextStyle(
                                  color: const Color(0xFF3D3D3D),
                                  fontSize: ScreenAdapter.fontSize(14),
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: ScreenAdapter.height(20)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(children: [
                                Image.asset('assets/images/home/center_01.png',
                                    width: ScreenAdapter.height(50),
                                    height: ScreenAdapter.height(50)),
                                const Text('求职服务',
                                    style: TextStyle(color: Color(0xFF3D3D3D)))
                              ]),
                              Column(children: [
                                Image.asset('assets/images/home/center_02.png',
                                    width: ScreenAdapter.height(50),
                                    height: ScreenAdapter.height(50)),
                                const Text('简历附件',
                                    style: TextStyle(color: Color(0xFF3D3D3D)))
                              ]),
                              Column(children: [
                                Image.asset('assets/images/home/center_03.png',
                                    width: ScreenAdapter.height(50),
                                    height: ScreenAdapter.height(50)),
                                const Text('求职期望 ',
                                    style: TextStyle(color: Color(0xFF3D3D3D)))
                              ]),
                            ],
                          ),
                        ]),
                  ),
                ),
                SizedBox(height: ScreenAdapter.height(23)),
                Container(
                  height: ScreenAdapter.height(240),
                  width: ScreenAdapter.width(335),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/home/center_04.png',
                            width: ScreenAdapter.height(90),
                            height: ScreenAdapter.height(90)),
                        const Text('更多功能，敬请期待',
                            style: TextStyle(color: Color(0xFF999999)))
                      ]),
                )
              ]),
            )
          ]),
        ),
      )
    ]));
  }
}
