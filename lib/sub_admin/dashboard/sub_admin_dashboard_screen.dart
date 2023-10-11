// import 'package:admin_panel_so/constant/app_color.dart';
// import 'package:admin_panel_so/utils/responsive.dart';
// import 'package:admin_panel_so/utils/shared_widget/appTextStyle.dart';
// import 'package:admin_panel_so/utils/shared_widget/sub_admin_drawer.dart';
// import 'package:admin_panel_so/utils/static_data.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'sub_admin_dashboad_controller.dart';
//
// class SubAdminDashboard extends StatefulWidget {
//   const SubAdminDashboard({super.key});
//
//   @override
//   State<SubAdminDashboard> createState() => _SubAdminDashboardState();
// }
//
// class _SubAdminDashboardState extends State<SubAdminDashboard> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   void openDrawer() {
//     _scaffoldKey.currentState?.openDrawer();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SubAdminDashboardController>(
//       init: Get.put(SubAdminDashboardController()),
//       builder: (obj) {
//         return Scaffold(
//           extendBodyBehindAppBar: true,
//           key: _scaffoldKey,
//           appBar: !Responsive.isDesktop(context)
//               ? AppBar(
//                   title: Text(obj.screenName[obj.selectedIndex.value]),
//                   actions: [
//                     CircleAvatar(
//                         backgroundColor: primary,
//                         child:
//                          AppTextStyle(
//                           text: StaticData.userProfile !=null ?
//                           StaticData.userProfile!.data!.name![0]: "",
//                           textColor: appWhite,
//                           fontSize: 18,
//                         ))
//                   ],
//                   iconTheme: const IconThemeData(color: white),
//                   backgroundColor: Colors.transparent,
//                   elevation: 0,
//                 )
//               : null,
//           body: Row(
//             children: [
//               if (Responsive.isDesktop(context)) const SubAdminDrawer(),
//               Expanded(
//                   child: SafeArea(
//                       child: Scaffold(
//                           body:
//                               ScreenManager.screens[obj.selectedIndex.value])))
//             ],
//           ),
//           drawer: const SubAdminDrawer(),
//         );
//       },
//     );
//   }
// }

import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/sub_admin/dashboard/sub_admin_dashboad_controller.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/utils/shared_widget/sub_admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/shared_widget/appTextStyle.dart';
import '../../utils/static_data.dart';

class SubAdminDashboardScreen extends StatefulWidget {
  const SubAdminDashboardScreen({super.key});

  @override
  State<SubAdminDashboardScreen> createState() =>
      _SubAdminDashboardScreenState();
}

class _SubAdminDashboardScreenState extends State<SubAdminDashboardScreen> {
  final obj = Get.put(SubAdminDashboardController());

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              title: Obx(() => Text(obj.screenName[obj.selectedIndex.value])),
              actions: [
                CircleAvatar(
                    backgroundColor: primary,
                    child: AppTextStyle(
                      text: StaticData.userProfile != null
                          ? StaticData.userProfile!.data!.name![0]
                          : "",
                      textColor: appWhite,
                      fontSize: 18,
                    ))
              ],
              iconTheme: const IconThemeData(color: white),
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      body: Row(
        children: [
          if (Responsive.isDesktop(context)) const SubAdminDrawer(),
          Expanded(child: SafeArea(child: Scaffold(
            body: Obx(() {
              return ScreenManager.screens[controller.selectedIndex.value];
            }),
          )))
        ],
      ),
      drawer: const SubAdminDrawer(),
    );
  }
}
