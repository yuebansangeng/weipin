import 'package:get/get.dart';

import '../controllers/joblist_controller.dart';

class JoblistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoblistController>(
      () => JoblistController(),
    );
  }
}
