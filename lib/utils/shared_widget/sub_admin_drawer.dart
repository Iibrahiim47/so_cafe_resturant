import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/constant/shared_pref.dart';
import 'package:admin_panel_so/sub_admin/dashboard/sub_admin_dashboad_controller.dart';
import 'package:admin_panel_so/sub_admin/pages/sub_profile_page.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/utils/shared_widget/appTextStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/login.dart';
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(const SubProfilePage());
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: AppTextStyle(text:StaticData.userProfile!.data!.name![0].toUpperCase() +
                            StaticData.userProfile!.data!.name![1],fontSize: 20),
                  ),
                ),

                AppTextStyle(text: StaticData.userProfile!.data!.name.toString()) ,
                AppTextStyle(text: StaticData.userProfile!.data!.email.toString())
              ],
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

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: tileSpacing),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  title: const Text('Logout'),
                  tileColor: appSecondary,
                  titleTextStyle: Responsive.isDesktop(context)? const TextStyle(fontSize: 20):null,
                  onTap: () {
                    PreferencesService.clearPreferences().then((value){
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
