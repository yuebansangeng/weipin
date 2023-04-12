import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../services/screenAdapter.dart';
import '../controllers/home_controller.dart';
import '../../../services/weipinIcon.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(), //禁止左右滑动
            children: controller.pages,
            onPageChanged: (index) {
              controller.setCurrentIndex(index);
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
              fixedColor: Color.fromRGBO(36, 178, 255, 1),
              //选中的颜色
              currentIndex: controller.currentIndex.value,
              //第几个菜单选中
              type: BottomNavigationBarType.fixed,
              //如果底部有4个或者4个以上的菜单的时候就需要配置这个参数
              onTap: (index) {
                controller.setCurrentIndex(index);
                controller.pageController.jumpToPage(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/home/job.png",
                    width: ScreenAdapter.height(24),
                    height: ScreenAdapter.height(24),
                  ),
                  activeIcon: Image.asset(
                    "assets/images/home/job_hover.png",
                    width: ScreenAdapter.height(24),
                    height: ScreenAdapter.height(24),
                  ),
                  label: "职位",
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/home/me.png",
                      width: ScreenAdapter.height(24),
                      height: ScreenAdapter.height(24),
                    ),
                    activeIcon: Image.asset(
                      "assets/images/home/me_hover.png",
                      width: ScreenAdapter.height(24),
                      height: ScreenAdapter.height(24),
                    ),
                    label: "我的"),
              ]),
        ));
  }
}
