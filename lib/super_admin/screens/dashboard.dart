// import 'package:admin_panel_so/controller/admin_main_controller.dart';
// import 'package:admin_panel_so/controller/get_branch_controller/get_branch_controller.dart';
// import 'package:admin_panel_so/controller/get_users_profile_ontroller/get_user_profile_controller.dart';
// import 'package:admin_panel_so/super_admin/superAdmin_Dashboard/admin_mainDashboard/screens/pages/admin_page.dart';
// import 'package:admin_panel_so/super_admin/superAdmin_Dashboard/admin_mainDashboard/screens/pages/branch_page.dart';
// import 'package:admin_panel_so/super_admin/superAdmin_Dashboard/admin_mainDashboard/screens/pages/home_page/home_page.dart';
// import 'package:admin_panel_so/super_admin/superAdmin_Dashboard/admin_mainDashboard/screens/pages/menue_page.dart';
// import 'package:admin_panel_so/super_admin/superAdmin_Dashboard/admin_mainDashboard/screens/pages/menue_setting.dart';
// import 'package:admin_panel_so/super_admin/superAdmin_Dashboard/admin_mainDashboard/screens/pages/profile_page.dart';
// import 'package:admin_panel_so/utils/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../constant/app_color.dart';
//
// class AdminDashBoard extends StatefulWidget {
//   const AdminDashBoard({super.key});
//
//   @override
//   State<AdminDashBoard> createState() => _AdminDashBoardState();
// }
//
// class _AdminDashBoardState extends State<AdminDashBoard> {
//   @override
//   void initState() {
//     GetBranchListController.to.getBranchesMethod();
//     GetuserProfileController.to.getUserProfileMethod();
//     AdminMainController.to.getOwnerProfileMethod();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: GetBuilder<AdminMainController>(
//           initState: (state) {},
//           builder: (obj) {
//             return SizedBox(
//               height: height,
//               width: width,
//               child: Column(
//                 children: [
//                   Container(
//                     height: height * 0.1,
//                     width: width,
//                     color: primary,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: width * 0.03, right: width * 0.03),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             obj.branchName.toUpperCase(),
//                             style: TextStyle(
//                                 color: onPrimary,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: width * 0.02),
//                           ),
//                           SizedBox(
//                             height: height,
//                             width: width * 0.3,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   obj.adminName == "ADMIN NAME"
//                                       ? "ADMIN NAME"
//                                       : obj.adminName.toUpperCase(),
//                                   style: TextStyle(
//                                       color: onPrimary,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: width * 0.02),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(20.0),
//                                   child: Container(
//                                     height: height,
//                                     width: width * 0.05,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: onPrimary,
//                                             width: 3),
//                                         shape: BoxShape.circle),
//                                     child: Icon(
//                                       Icons.person,
//                                       color: onPrimary,
//                                       size: width * 0.02,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       height: height,
//                       width: width,
//                       color: onLightColor,
//                       child: Padding(
//                         padding: EdgeInsets.only(top: height * 0.01),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: height,
//                               width: width * 0.25,
//                               decoration: const BoxDecoration(
//                                   color: primary,
//                                   borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(20),
//                                       bottomRight: Radius.circular(20))),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     height: height * 0.05,
//                                   ),
//                                   obj.menue == "Dashboard"
//                                       ? Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Card(
//                                             elevation: 10,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: Container(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   border: Border.all(
//                                                       color: onPrimary)),
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.home,
//                                                     color:
//                                                         primary,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Dashboard",
//                                                     style: TextStyle(
//                                                         color: onPrimary,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       : Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               obj.changeMenue("Dashboard");
//                                             },
//                                             child: SizedBox(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.home,
//                                                     color: Colors.black,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Dashboard",
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                   SizedBox(
//                                     height: height * 0.002,
//                                   ),
//                                   obj.menue == "Admins"
//                                       ? Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Card(
//                                             elevation: 10,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: Container(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   border: Border.all(
//                                                       color:onPrimary)),
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.admin_panel_settings,
//                                                     color:
//                                                         primary,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Admins",
//                                                     style: TextStyle(
//                                                         color: onPrimary,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       : Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               obj.changeMenue("Admins");
//                                             },
//                                             child: SizedBox(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.admin_panel_settings,
//                                                     color: Colors.black,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Admins",
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                   SizedBox(
//                                     height: height * 0.002,
//                                   ),
//                                   obj.menue == "Branch"
//                                       ? Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Card(
//                                             elevation: 10,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: Container(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   border: Border.all(
//                                                       color: onPrimary)),
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.broadcast_on_home,
//                                                     color:
//                                                         primary,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Branches ",
//                                                     style: TextStyle(
//                                                         color: onPrimary,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       : Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               obj.changeMenue("Branch");
//                                             },
//                                             child: SizedBox(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.price_check_outlined,
//                                                     color: Colors.black,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Branches",
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                   SizedBox(
//                                     height: height * 0.002,
//                                   ),
//                                   obj.menue == "category"
//                                       ? Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Card(
//                                             elevation: 10,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: Container(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   border: Border.all(
//                                                       color: onPrimary)),
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.shopping_bag_outlined,
//                                                     color:
//                                                         primary,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Menue Category",
//                                                     style: TextStyle(
//                                                         color: onPrimary,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       : Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               obj.changeMenue("category");
//                                             },
//                                             child: SizedBox(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.shopping_bag_outlined,
//                                                     color: Colors.black,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Menue  Category",
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                   SizedBox(
//                                     height: height * 0.002,
//                                   ),
//                                   obj.menue == "menue"
//                                       ? Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Card(
//                                             elevation: 10,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: Container(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   border: Border.all(
//                                                       color: onPrimary)),
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.store,
//                                                     color:
//                                                         primary,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Menue",
//                                                     style: TextStyle(
//                                                         color:onPrimary,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       : Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               obj.changeMenue("menue");
//                                             },
//                                             child: SizedBox(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.shopping_bag_outlined,
//                                                     color: Colors.black,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Menue ",
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                   SizedBox(
//                                     height: height * 0.002,
//                                   ),
//                                   obj.menue == "profile"
//                                       ? Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Card(
//                                             elevation: 10,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: Container(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   border: Border.all(
//                                                       color: onPrimary)),
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.store,
//                                                     color:
//                                                         primary,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Profile",
//                                                     style: TextStyle(
//                                                         color: onPrimary,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       : Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               obj.changeMenue("profile");
//                                             },
//                                             child: SizedBox(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.shopping_bag_outlined,
//                                                     color: Colors.black,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Profile ",
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                   SizedBox(
//                                     height: height * 0.002,
//                                   ),
//                                   obj.menue == "settings"
//                                       ? Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Card(
//                                             elevation: 10,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: Container(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   border: Border.all(
//                                                       color: onPrimary)),
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.store,
//                                                     color:
//                                                         primary,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Menue Settings ",
//                                                     style: TextStyle(
//                                                         color: onPrimary,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       : Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               obj.changeMenue("settings");
//                                             },
//                                             child: SizedBox(
//                                               height: height * 0.07,
//                                               width: width * 0.8,
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: width * 0.01,
//                                                   ),
//                                                   Icon(
//                                                     Icons.shopping_bag_outlined,
//                                                     color: Colors.black,
//                                                     size: width * 0.02,
//                                                   ),
//                                                   Text(
//                                                     " Menue Settings ",
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize:
//                                                             width * 0.015),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                   // SizedBox(
//                                   //   height: height * 0.002,
//                                   // ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: InkWell(
//                                       onTap: () {},
//                                       child: SizedBox(
//                                         height: height * 0.07,
//                                         width: width * 0.8,
//                                         child: Row(
//                                           children: [
//                                             SizedBox(
//                                               width: width * 0.01,
//                                             ),
//                                             Icon(
//                                               Icons.logout,
//                                               color: Colors.black,
//                                               size: width * 0.02,
//                                             ),
//                                             Text(
//                                               " LogOut ",
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: width * 0.015),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: height * 0.01,
//                                   )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: width * 0.01,
//                             ),
//                             Expanded(
//                               child: SizedBox(
//                                 height: height,
//                                 width: width,
//                                 child: obj.menue == "Dashboard"
//                                     ? const HomePage()
//                                     : obj.menue == "Admins"
//                                         ? const AdminPage()
//                                         : obj.menue == "Branch"
//                                             ? const BranchPage()
//                                             : obj.menue == "menue"
//                                                 ? const MenuePage()
//                                                 : obj.menue == "profile"
//                                                     ? const ProfilePage()
//                                                     : obj.menue == "settings"
//                                                           ? const MenueSettingPage()
//                                                         : const SizedBox(),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
