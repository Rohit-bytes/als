import 'package:get/get.dart';

import '../viewmodel/splash_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(), permanent: true);
  }
}
