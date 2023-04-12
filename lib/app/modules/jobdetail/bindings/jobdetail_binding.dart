import 'package:get/get.dart';

import '../controllers/jobdetail_controller.dart';

class JobdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobdetailController>(
      () => JobdetailController(),
    );
  }
}
