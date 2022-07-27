import 'package:get/get.dart';

import 'logic.dart';

class LoginPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPinLogic());
  }
}
