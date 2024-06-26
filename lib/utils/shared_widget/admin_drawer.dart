import 'package:admin_panel_so/constant/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/login.dart';
import '../../constant/shared_pref.dart';
import '../../super_admin/dashborad/admin_mainDashboad_controller.dart';
import '../responsive.dart';
import '../static_data.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

final controller = Get.put(AdminMainDashboardController());

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    final double tileSpacing = MediaQuery.of(context).size.height *
        0.02; // Adjust the spacing as needed

    return Drawer(
      elevation: 0,
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(),
            child: CircleAvatar(
              maxRadius: 40,
                backgroundColor: primary,
                backgroundImage: AssetImage('images/logo.png'),
            ),
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
              title: const Text('Admins'),
              onTap: () {
                drawerTap(1);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: tileSpacing),
            child: ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Branches'),
              onTap: () {
                drawerTap(2);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: tileSpacing),
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                drawerTap(3);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: tileSpacing),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  title: const Text('Logout'),
                  tileColor: appSecondary,
                  titleTextStyle: Responsive.isDesktop(context)
                      ? const TextStyle(fontSize: 20)
                      : null,
                  onTap: () {
                    PreferencesService.clearPreferences().then((value) {
                      Get.offAll((const AdminPannelLoginPage()));
                    });
                  },
                ),
              ),
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
