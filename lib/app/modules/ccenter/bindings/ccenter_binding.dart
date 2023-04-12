import 'package:get/get.dart';

import '../controllers/ccenter_controller.dart';

class CcenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CcenterController>(
      () => CcenterController(),
    );
  }
}
