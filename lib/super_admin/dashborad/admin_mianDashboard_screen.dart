import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/utils/shared_widget/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/static_data.dart';
import 'admin_mainDashboad_controller.dart';


class AdminMainDashboard extends StatefulWidget {
  const AdminMainDashboard({super.key});

  @override
  State<AdminMainDashboard> createState() => _AdminMainDashboardState();
}

class _AdminMainDashboardState extends State<AdminMainDashboard> {
  final controller = Get.put(AdminMainDashboardController());

  void initState() {
    // GetBranchListController.to.getBranchesMethod();
    // AdminMainController.to.getOwnerProfileMethod();
    super.initState();
  }

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
              iconTheme: const IconThemeData(color: white),
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      body: Row(
        children: [
          if (Responsive.isDesktop(context)) const AdminDrawer(),
          Expanded(child: SafeArea(child: Scaffold(
            body: Obx(() {
              return ScreenManager.screens[controller.selectedIndex.value];
            }),
          )))
        ],
      ),
      drawer: const AdminDrawer(),
    );
  }
}
