import 'package:admin_panel_so/sub_admin/pages/sub_home/sub_homePage.dart';
import 'package:admin_panel_so/sub_admin/pages/sub_menupage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SubAdminDashboardController extends GetxController{
  static SubAdminDashboardController get instance => Get.find();

  List screenName = ['Home', 'Menu', 'Orders', 'Feedback'].obs;
  RxInt selectedIndex =0.obs;
  final screenManager = ScreenManager();


  void onItemTap(int index){
    selectedIndex.value = index;
    update();
  }

}

class ScreenManager {
  static List<Widget> screens = [
    const SubHomePage(),
    const SubMenuPage()
  ];
}
