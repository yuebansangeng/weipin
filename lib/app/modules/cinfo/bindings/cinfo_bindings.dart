import 'package:get/get.dart';

import '../controllers/cinfo_controller.dart';
import '../../step1/controllers/step1_controller.dart';
import '../../step2/controllers/step2_controller.dart';

class CInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CInfoController>(
      () => CInfoController(),
    );
    Get.lazyPut<Step1Controller>(
      () => Step1Controller(),
    );
    Get.lazyPut<Step2Controller>(
      () => Step2Controller(),
    );
  }
}
