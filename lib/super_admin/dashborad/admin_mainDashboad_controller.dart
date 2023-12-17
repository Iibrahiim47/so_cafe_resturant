
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/pages/admin_page.dart';
import '../screens/pages/branch_page.dart';
import '../screens/pages/home_page/home_page.dart';
import '../screens/pages/logout_page.dart';

class AdminMainDashboardController extends GetxController{
  static AdminMainDashboardController get instance => Get.find();

  List screenName = ['Home', 'Product', 'Store', 'Setting'].obs;
  RxInt selectedIndex =0.obs;
  final screenManager = ScreenManager();


  void onItemTap(int index){
    selectedIndex.value = index;
    update();
  }

}

class ScreenManager {
  static List<Widget> screens = [
    const HomePage(),
    const AdminPage(),
     const BranchPage(),
     const LogoutPage(),
  ];
}
