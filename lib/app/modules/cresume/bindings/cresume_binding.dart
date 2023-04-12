import 'package:get/get.dart';

import '../controllers/cresume_controller.dart';

class CresumeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CresumeController>(
      () => CresumeController(),
    );
  }
}
