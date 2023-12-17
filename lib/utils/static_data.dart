import 'package:admin_panel_so/models/admin_model.dart';
import 'package:flutter/material.dart';

import '../sub_admin/model/sub_admin_profile_model.dart';

class StaticData {
  static String? adminId;
  static SubAdminProfileModel? userProfile;

  static AdminModel? adminModel;
  static String? token;
}
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


List<int?> allBranch_Ids = [];

int? selectedCategory;
String token = '';
bool isAdmin = false;