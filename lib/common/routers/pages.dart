import 'package:flutter/material.dart';
import 'package:keep/common/middlewares/middlewares.dart';
import 'package:keep/pages/add_vip/view.dart';
import 'package:keep/pages/amap/binding.dart';
import 'package:keep/pages/amap/view.dart';
import 'package:keep/pages/application/index.dart';
import 'package:keep/pages/calcucation/binding.dart';
import 'package:keep/pages/calcucation/view.dart';
import 'package:keep/pages/calcucation_detail/binding.dart';
import 'package:keep/pages/calcucation_detail/view.dart';
import 'package:keep/pages/calcucation_exact/binding.dart';
import 'package:keep/pages/calcucation_exact/view.dart';
import 'package:keep/pages/calcucation_prepare/view.dart';
import 'package:keep/pages/change_account/binding.dart';
import 'package:keep/pages/change_account/view.dart';
import 'package:keep/pages/change_jump/binding.dart';
import 'package:keep/pages/change_jump/view.dart';
import 'package:keep/pages/channel/binding.dart';
import 'package:keep/pages/channel/view.dart';
import 'package:keep/pages/create_user/binding.dart';
import 'package:keep/pages/create_user/view.dart';
import 'package:keep/pages/distribute/binding.dart';
import 'package:keep/pages/distribute/view.dart';
import 'package:keep/pages/frame/login/binding.dart';
import 'package:keep/pages/frame/login/view.dart';
import 'package:keep/pages/frame/login_pin/view.dart';
import 'package:keep/pages/frame/login_video/binding.dart';
import 'package:keep/pages/frame/sign_in/index.dart';
import 'package:keep/pages/frame/sign_up/index.dart';
import 'package:keep/pages/frame/welcome/index.dart';
import 'package:keep/pages/group_chat/binding.dart';
import 'package:keep/pages/group_chat/view.dart';
import 'package:keep/pages/home/view.dart';
import 'package:keep/pages/oa/about_us/about_us_binding.dart';
import 'package:keep/pages/oa/about_us/about_us_view.dart';
import 'package:keep/pages/oa/application/index.dart';
import 'package:keep/pages/oa/home_message/binding.dart';
import 'package:keep/pages/oa/home_message/view.dart';
import 'package:keep/pages/oa/person/binding.dart';
import 'package:keep/pages/oa/person/follow/binding.dart';
import 'package:keep/pages/oa/person/view.dart';
import 'package:keep/pages/oa/user_detail/binding.dart';
import 'package:keep/pages/oa/user_detail/view.dart';
import 'package:keep/pages/oa/work/binding.dart';
import 'package:keep/pages/oa/work/view.dart';
import 'package:keep/pages/other/fine/view.dart';
import 'package:keep/pages/other/fine_detail/view.dart';
import 'package:keep/pages/other/webview/binding.dart';
import 'package:keep/pages/other/webview/view.dart';
import 'package:keep/pages/peer_chat/binding.dart';
import 'package:keep/pages/peer_chat/view.dart';
import 'package:keep/pages/search/binding.dart';
import 'package:keep/pages/search/view.dart';
import 'package:keep/pages/search_appoint/view.dart';
import 'package:keep/pages/search_flow/binding.dart';
import 'package:keep/pages/search_flow/view.dart';
import 'package:keep/pages/setting/binding.dart';
import 'package:keep/pages/setting/view.dart';
import 'package:keep/pages/user_detail/binding.dart';
import 'package:keep/pages/user_detail/view.dart';
import 'package:get/get.dart';
import '../../pages/add_vip/binding.dart';
import '../../pages/calcucation_prepare/binding.dart';
import '../../pages/calcucation_result/binding.dart';
import '../../pages/calcucation_result/view.dart';
import '../../pages/frame/login_pin/binding.dart';
import '../../pages/frame/login_video/view.dart';
import '../../pages/friend/binding.dart';
import '../../pages/friend/view.dart';
import '../../pages/home/binding.dart';
import '../../pages/oa/person/follow/view.dart';
import '../../pages/oa/person/public/binding.dart';
import '../../pages/oa/person/public/view.dart';
import '../../pages/other/fine/binding.dart';
import '../../pages/other/fine_detail/binding.dart';
import '../../pages/search_appoint/binding.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // ?????????
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),

    // ????????????
    GetPage(
      name: AppRoutes.Application,
      page: () => ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: AppRoutes.Home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.Detail,
      page: () => UserDetailPage(),
      binding: UserDetailBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: AppRoutes.BuyVip,
        page: () => AddVipPage(),
        binding: AddVipBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.Distribute,
        page: () => DistributePage(),
        binding: DistributeBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.Peer,
        page: () => PeerChatPage(),
        binding: PeerChatBinding(),
        transition: Transition.rightToLeft
    ),

    GetPage(
        name: AppRoutes.Setting,
        page: () => SettingPage(),
        binding: SettingBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.CreateUser,
        page: () => CreateUserPage(),
        binding: CreateUserBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.SearchUser,
        page: () => SearchPage(),
        binding: SearchBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.Amap,
        page: () => AmapPage(),
        binding: AmapBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.SearchUserAppoint,
        page: () => SearchAppointPage(),
        binding: SearchAppointBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.Fine,
        page: () => FinePage(),
        binding: FineBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.SearchFlow,
        page: () => SearchFlowPage(),
        binding: SearchFlowBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.Webview,
        page: () => WebviewPage(),
        binding: WebviewBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.GroupChat,
        page: () => GroupChatPage(),
        binding: GroupChatBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.FineDetail,
        page: () => FineDetailPage(),
        binding: FineDetailBinding(),
        transition: Transition.rightToLeft
    ),

    GetPage(
        name: AppRoutes.OAApplication,
        page: () => OAApplicationPage(),
        binding: OAApplicationBinding(),
        transition: Transition.rightToLeft
    ),

    GetPage(
        name: AppRoutes.HomeMessage,
        page: () => HomeMessagePage(),
        binding: HomeMessageBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.Work,
        page: () => WorkPage(),
        binding: WorkBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.Person,
        page: () => PersonPage(),
        binding: PersonBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.OADetail,
        page: () => OAUserDetailPage(),
        binding: OAUserDetailBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.AboutUs,
        page: () => AboutUsPage(),
        binding: AboutUsBinding(),
        transition: Transition.rightToLeft
    ),

    GetPage(
        name: AppRoutes.Follow,
        page: () => FollowPage(),
        binding: FollowBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.Public,
        page: () => PublicPage(),
        binding: PublicBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.Calcucation,
        page: () => CalcucationPage(),
        binding: CalcucationBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.ChangeAccount,
        page: () => ChangeAccountPage(),
        binding: ChangeAccountBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.ChangeJump,
        page: () => ChangeJumpPage(),
        binding: ChangeJumpBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.CalcucationList,
        page: () => CalcucationDetailPage(),
        binding: CalcucationDetailBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.CalcucationPrepare,
        page: () => CalcucationPreparePage(),
        binding: CalcucationPrepareBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.CalcucationResult,
        page: () => CalcucationResultPage(),
        binding: CalcucationResultBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.CalcucationExact,
        page: () => CalcucationExactPage(),
        binding: CalcucationExactBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.Friend,
        page: () => FriendPage(),
        binding: FriendBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.Channel,
        page: () => ChannelPage(),
        binding: ChannelBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.LoginVideo,
        page: () => LoginVideoPage(),
        binding: LoginVideoBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.LoginPin,
        page: () => LoginPinPage(),
        binding: LoginPinBinding(),
        transition: Transition.rightToLeft
    ),
  ];

  // static final unknownRoute = GetPage(
  //   name: AppRoutes.NotFound,
  //   page: () => NotfoundView(),
  // );

}
class SizeTransitions extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
        opacity:  CurvedAnimation(
        parent: animation,
        curve: curve!,
      ),
        child: child,
    );
  }
}