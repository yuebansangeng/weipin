import 'package:get/get.dart';

import '../controllers/choose_controller.dart';

class ChooseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseController>(
      () => ChooseController(),
    );
  }
}
