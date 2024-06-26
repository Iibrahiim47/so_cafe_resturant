import 'package:admin_panel_so/sub_admin/pages/sub_home/sub_homePage.dart';
import 'package:admin_panel_so/sub_admin/pages/sub_menu_page.dart';
import 'package:admin_panel_so/sub_admin/pages/get_review_page.dart';
import 'package:admin_panel_so/sub_admin/pages/sub_order/sub_order_page.dart';
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
    const SubMenuPage(),
    const SubOrderPage(),
    const GetReviewsPage()

  ];
}
