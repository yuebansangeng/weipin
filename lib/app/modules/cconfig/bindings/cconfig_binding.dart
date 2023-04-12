import 'package:get/get.dart';

import '../controllers/cconfig_controller.dart';

class CconfigBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CconfigController>(
      () => CconfigController(),
    );
  }
}
