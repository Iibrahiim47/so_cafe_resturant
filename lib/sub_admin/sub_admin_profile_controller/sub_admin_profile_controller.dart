import 'dart:convert';

import 'package:admin_panel_so/sub_admin/model/sub_admin_profile_model.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SubAdminProfileController extends GetxController {
  static SubAdminProfileController get to => Get.find();
  String? subAdmin = "Dashboard";
  String adminName = "ADMIN NAME";
  String branchName = "BRANCH NAME";
  int? branchId;

  changeSubAdminMenue(String v) {
    subAdmin = v;
    update();
  }

  SubAdminProfileModel? model;

  http.Response? response;

  Future<void> getSubAdminProfileMethod() async {
    response = await http.get(
      Uri.parse(StaticValues.getusersProfilUrl),
      headers: <String, String>{
        'Content-type': 'application/json; charset=utf-8',
        "Authorization": " Bearer ${StaticData.token}"
      },
    );
    if (response!.statusCode == 200) {
      model = SubAdminProfileModel.fromJson(jsonDecode(response!.body));
      branchId = model!.data!.branchId;
      adminName = model!.data!.name!;
      branchName = model!.data!.branchName!;
    }

    update();
  }
}
