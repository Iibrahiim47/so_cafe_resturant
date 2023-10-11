import 'dart:convert';

import 'package:admin_panel_so/controller/get_users_profile_ontroller/get_user_profile_controller.dart';
import 'package:admin_panel_so/models/get_branches.dart';
import 'package:admin_panel_so/models/signup_model.dart';
import 'package:admin_panel_so/utils/app_toast.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddAdminController extends GetxController {
  static AddAdminController get to => Get.find();
  String adminName = "ADMIN NAME";
  String branchName = "BRANCH NAME";
  String? selectedBranchName;
  String? selectedBranchAddress;
  int? selectedBranchId;
  Data? selectedBranch;
  List<Data> branchList = []; // Replace Data with your data model class

  RxBool psdObs = true.obs;
  RxBool isLoading = false.obs;

  bool isLoading2 = false;




  Future<SignupResponseModel> addAdminMethod(SignupResponseModel model) async {
    print(StaticValues.userLoginUrl);
    http.Response response =
        await http.post(Uri.parse(StaticValues.userSignUpUrl),
            headers: <String, String>{
              "Content-type": " application/json-patch+json",
              "Authorization": " Bearer ${StaticData.token}"
            },
            body: jsonEncode(model.toMap()));
    print("Status code-- ${response.statusCode}");
    print(response.body);
    if (response.statusCode == 200) {
      return SignupResponseModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed To Load Model');
    }
  }

  ////////////////////// Depart Drop Down//////////////////////////////

  Future<void> fetchDropDownBranchList() async {
    try {
      final result = await http.get(
        Uri.parse(StaticValues.getBranchUrl),
        headers: <String, String>{
          'Content-type': 'application/json; charset=utf-8',
          "Authorization": "Bearer ${StaticData.token}"
        },
      );

      if (result.statusCode == 200) {
        final branches = GetBranchModel.fromJson(jsonDecode(result.body));
        if (branches.data != null) {
            branchList = branches.data!;
        }
      } else {
        // Handle error cases here
        throw Exception('Failed to fetch branches: ${result.statusCode}');
      }
    } catch (e) {
      // Handle exceptions here
      throw Exception('Failed to fetch branches: $e');
    }
  }


  Future<SignupResponseModel?> deleteSubAdmin(int userId) async {

    http.Response response =
    await http.delete(
      Uri.parse("${StaticValues.deleteUser}$userId"), // Replace with your DELETE endpoint
      headers: <String, String>{
        "Content-type": "application/json-patch+json",
        "Authorization": "Bearer ${StaticData.token}"
      },

    );
    print("Status code-- ${response.statusCode}");
    print(response.body);
    if (response.statusCode == 200) {
      return SignupResponseModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed To Load Model');
    }
  }

}
