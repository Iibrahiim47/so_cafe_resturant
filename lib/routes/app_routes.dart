import 'package:admin_panel_so/routes/routes_name.dart';
import 'package:admin_panel_so/splash_screen.dart';
import 'package:admin_panel_so/sub_admin/dashboard/sub_admin_dashboard_screen.dart';
import 'package:get/get.dart';

import '../super_admin/dashborad/admin_mianDashboard_screen.dart';
import '../auth/login.dart';

class AppRoutes {
  static List<GetPage> appRoutes() => [
        GetPage(
          name: RoutesName.splash_screen,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: RoutesName.admin_login_page,
          page: () => const AdminPannelLoginPage(),
        ),
        GetPage(
          name: RoutesName.admin_main_dashboard,
          page: () => const AdminMainDashboard(),
        ),
    GetPage(
          name: RoutesName.sub_admin_dashboard,
          page: () => const SubAdminDashboardScreen(),
        ),
      ];
}
