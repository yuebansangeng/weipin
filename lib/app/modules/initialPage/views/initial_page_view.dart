import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/initial_page_controller.dart';
import '../../../services/screenAdapter.dart';

class InitialPageView extends GetView<InitialPageController> {
  const InitialPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        //消除阴影
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: controller.inited.value
          ? Center(
              child: Image.asset(
                "assets/images/login/logo_screen.png",
                width: ScreenAdapter.width(117),
                height: ScreenAdapter.height(163),
              ),
            )
          : const SizedBox(),
    );
  }
}
