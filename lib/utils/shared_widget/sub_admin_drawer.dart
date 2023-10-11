import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/sub_admin/dashboard/sub_admin_dashboad_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../static_data.dart';

class SubAdminDrawer extends StatefulWidget {
  const SubAdminDrawer({Key? key}) : super(key: key);

  @override
  State<SubAdminDrawer> createState() => _SubAdminDrawerState();
}

final controller = Get.put(SubAdminDashboardController());

class _SubAdminDrawerState extends State<SubAdminDrawer> {
  @override
  Widget build(BuildContext context) {
    final double tileSpacing = MediaQuery.of(context).size.height *
        0.02; // Adjust the spacing as needed

    return Drawer(
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: primary,
            ),
            child: Image.asset('images/logo.png'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: tileSpacing),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                drawerTap(0);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: tileSpacing),
            child: ListTile(
              leading: const Icon(CupertinoIcons.person_crop_circle_fill),
              title: const Text('Menu'),
              onTap: () {
                drawerTap(1);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: tileSpacing),
            child: ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Orders'),
              onTap: () {
                drawerTap(2);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: tileSpacing),
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Feedback'),
              onTap: () {
                drawerTap(3);
              },
            ),
          ),
        ],
      ),
    );
  }

  drawerTap(index) {
    controller.onItemTap(index);
    closeDrawer();

  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }
}
