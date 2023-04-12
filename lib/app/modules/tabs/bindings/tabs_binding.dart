import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';
import '../../verifyPhone/controllers/verify_phone_controller.dart';
import '../../login/controllers/login_controller.dart';
import '../../area/controllers/area_controller.dart';
import '../../guide/controllers/guide_controller.dart';
import '../../cinfo/controllers/cinfo_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(
      () => TabsController(),
    );
    Get.lazyPut<VerifyPhoneController>(
      () => VerifyPhoneController(),
    );

    Get.lazyPut<AreaController>(
      () => AreaController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<GuideController>(
      () => GuideController(),
    );
    Get.lazyPut<CInfoController>(
      () => CInfoController(),
    );
  }
}
