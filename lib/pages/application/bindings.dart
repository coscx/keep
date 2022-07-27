import 'package:keep/common/entities/loan/saleman.dart';
import 'package:keep/pages/calcucation/logic.dart';
import 'package:keep/pages/channel/logic.dart';
import 'package:keep/pages/conversion/logic.dart';
import 'package:keep/pages/flow_page/logic.dart';
import 'package:keep/pages/home/logic.dart';
import 'package:keep/pages/main/index.dart';
import 'package:keep/pages/other/fine/logic.dart';
import 'package:keep/pages/total_user/logic.dart';
import 'package:get/get.dart';
import '../mine/logic.dart';
import 'controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<TotalUserLogic>(() => TotalUserLogic());
    Get.lazyPut<FineLogic>(() => FineLogic());
    Get.lazyPut<ChannelLogic>(() => ChannelLogic());
    Get.lazyPut<CalcucationLogic>(() => CalcucationLogic());
    Get.lazyPut<HomeLogic>(() => HomeLogic());
    Get.lazyPut<MineLogic>(() => MineLogic());
    Get.lazyPut<ConversionLogic>(() => ConversionLogic());
  }
}
