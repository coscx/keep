import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keep/common/utils/iconfont.dart';
import 'package:keep/common/values/values.dart';
import 'package:keep/common/widgets/unit_bottom_bar.dart';
import 'package:keep/common/widgets/widgets.dart';
import 'package:keep/pages/calcucation/view.dart';
import 'package:keep/pages/channel/view.dart';

import 'package:keep/pages/conversion/view.dart';
import 'package:keep/pages/flow_page/view.dart';
import 'package:keep/pages/home/view.dart';
import 'package:keep/pages/main/index.dart';
import 'package:keep/pages/mine/view.dart';
import 'package:keep/pages/other/fine/view.dart';
import 'package:keep/pages/total_user/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/widgets/back_top_window.dart';
import 'index.dart';

class ApplicationPage extends GetView<ApplicationController> {
  // 顶部导航
  AppBar _buildAppBar() {
    return transparentAppBar(
        title: Obx(() => Text(
              controller.tabTitles[controller.state.page],
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: 'Montserrat',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            )),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColors.primaryText,
            ),
            onPressed: () {},
          )
        ]);
  }

  // 内容页
  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        TotalUserPage(),
        ChannelPage(),
        CalcucationPage(),
        ConversionPage(),
        MinePage(),
      ],
      controller: controller.pageController,
      onPageChanged: controller.handlePageChanged,
    );
  }

// 底部导航
  Widget _buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
      items: controller.bottomTabs,
      currentIndex: controller.state.page,
      // fixedColor: AppColors.primaryElement,
      type: BottomNavigationBarType.fixed,
      onTap: controller.handleNavBarTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ));
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: AndroidBackTop.backDesktop, //页面将要消失时，调用原生的返回桌面方法
        child: Theme(
          data: ThemeData(
            appBarTheme: AppBarTheme.of(context).copyWith(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light, // Status bar
              ),
            ),
          ),
          child: Scaffold(
      //appBar: _buildAppBar(),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    ),
        ));
  }
}