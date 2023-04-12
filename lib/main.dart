import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './widget/hideKeyboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ScreenUtilInit(
      designSize: const Size(375, 812), //设计稿的宽度和高度 px
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return HideKeyboard(
            child: GetMaterialApp(
                title: "Application",
                debugShowCheckedModeBanner: false,
                initialRoute: AppPages.INITIAL,
                theme: ThemeData(
                    primaryColor: Colors.grey, primarySwatch: Colors.grey),
                //配置ios动画
                defaultTransition: Transition.rightToLeft,
                getPages: AppPages.routes));
      }));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}
