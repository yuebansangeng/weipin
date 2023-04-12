import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';

import '../modules/area/views/area_view.dart';
import '../modules/ccenter/bindings/ccenter_binding.dart';
import '../modules/ccenter/views/ccenter_view.dart';
import '../modules/cconfig/bindings/cconfig_binding.dart';
import '../modules/cconfig/views/cconfig_view.dart';
import '../modules/choose/bindings/choose_binding.dart';
import '../modules/choose/views/choose_view.dart';
import '../modules/cinfo/bindings/cinfo_bindings.dart';
import '../modules/cinfo/views/cinfo_view.dart';
import '../modules/city/bindings/city_binding.dart';
import '../modules/city/views/city_view.dart';
import '../modules/cresume/bindings/cresume_binding.dart';
import '../modules/cresume/views/cresume_view.dart';
import '../modules/guide/bindings/guide_binding.dart';
import '../modules/guide/views/guide_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/initialPage/bindings/initial_page_binding.dart';
import '../modules/initialPage/views/initial_page_view.dart';
import '../modules/jobdetail/bindings/jobdetail_binding.dart';
import '../modules/jobdetail/views/jobdetail_view.dart';
import '../modules/joblist/bindings/joblist_binding.dart';
import '../modules/joblist/views/joblist_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/position/bindings/position_binding.dart';
import '../modules/position/views/position_view.dart';
import '../modules/step2/bindings/step2_binding.dart';
import '../modules/step2/views/step2_view.dart';
import '../modules/tabs/bindings/tabs_binding.dart';
import '../modules/tabs/views/tabs_view.dart';
import '../modules/verifyPhone/bindings/verify_phone_binding.dart';
import '../modules/verifyPhone/views/verify_phone_view.dart';

// import '../modules/area/bindings/area_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIAL_PAGE;

  // static const INITIAL = Routes.LOGIN;

  // static const INITIAL = Routes.AREA;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CINFO,
      page: () => const CinfoView(),
      binding: CInfoBinding(),
    ),
    GetPage(
      name: _Paths.JOBLIST,
      page: () => const JoblistView(),
      binding: JoblistBinding(),
    ),
    GetPage(
      name: _Paths.JOBDETAIL,
      page: () => const JobdetailView(),
      binding: JobdetailBinding(),
    ),
    GetPage(
      name: _Paths.CCENTER,
      page: () => const CcenterView(),
      binding: CcenterBinding(),
    ),
    GetPage(
      name: _Paths.CCONFIG,
      page: () => const CconfigView(),
      binding: CconfigBinding(),
    ),
    GetPage(
      name: _Paths.CRESUME,
      page: () => const CresumeView(),
      binding: CresumeBinding(),
    ),
    // GetPage(
    //   name: _Paths.AREA,
    //   page: () => const AreaView(),
    //   binding: AreaBinding(),
    // ),
    GetPage(
      name: _Paths.GUIDE,
      page: () => const GuideView(),
      binding: GuideBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_PHONE,
      page: () => VerifyPhoneView(),
      binding: VerifyPhoneBinding(),
    ),
    GetPage(
      name: _Paths.TABS,
      page: () => const TabsView(),
      binding: TabsBinding(),
    ),
    // GetPage(
    //   name: _Paths.STEP2,
    //   page: () => const Step2View(),
    //   binding: Step2Binding(),
    // ),
    GetPage(
      name: _Paths.H5,
      transitionDuration: const Duration(seconds: 0),
      page: () => WebviewScaffold(
        url: "https://www.baidu.com",
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            //消除阴影
            title: const Text("用户协议")),
      ),
    ),
    GetPage(
      name: _Paths.CITY,
      page: () => const CityView(),
      binding: CityBinding(),
    ),
    GetPage(
      name: _Paths.POSITION,
      page: () => const PositionView(),
      binding: PositionBinding(),
    ),
    GetPage(
      name: _Paths.INITIAL_PAGE,
      page: () => const InitialPageView(),
      binding: InitialPageBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE,
      page: () => const ChooseView(),
      binding: ChooseBinding(),
    ),
  ];
}
