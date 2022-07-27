import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widget/login_video_page.dart';
import 'logic.dart';

class LoginVideoPage extends StatelessWidget {
  final logic = Get.find<LoginVideoLogic>();
  final state = Get.find<LoginVideoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return LoginVideosPage();
  }
}
