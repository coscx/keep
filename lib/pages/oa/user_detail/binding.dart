import 'package:keep/pages/search/logic.dart';
import 'package:keep/pages/search/view.dart';
import 'package:get/get.dart';

import 'logic.dart';

class OAUserDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OAUserDetailLogic());
    Get.lazyPut(() => SearchLogic());
  }
}
