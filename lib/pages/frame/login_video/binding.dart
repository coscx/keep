import 'package:get/get.dart';

import 'logic.dart';

class LoginVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginVideoLogic());
  }
}
