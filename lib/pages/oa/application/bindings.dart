import 'package:keep/pages/conversion/logic.dart';
import 'package:keep/pages/conversion/view.dart';
import 'package:keep/pages/flow_page/logic.dart';
import 'package:keep/pages/frame/login/logic.dart';
import 'package:keep/pages/home/logic.dart';
import 'package:keep/pages/main/index.dart';
import 'package:keep/pages/oa/home_message/logic.dart';
import 'package:keep/pages/oa/person/logic.dart';
import 'package:keep/pages/oa/work/logic.dart';
import 'package:keep/pages/peer_chat/logic.dart';
import 'package:get/get.dart';

import 'controller.dart';

class OAApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OAApplicationController>(() => OAApplicationController());
    Get.lazyPut<HomeMessageLogic>(() => HomeMessageLogic());
    Get.lazyPut<PersonLogic>(() => PersonLogic());
    Get.lazyPut<WorkLogic>(() => WorkLogic());

  }
}
