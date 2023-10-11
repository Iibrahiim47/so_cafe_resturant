// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:admin_panel_so/models/admin_model.dart';
import 'package:admin_panel_so/models/branch_model.dart';
import 'package:admin_panel_so/models/get_owner_model.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminMainController extends GetxController {
  static AdminMainController get to => Get.find();
  bool psdObs = true;
  bool isLoading = false;

  loading(){
   isLoading = !isLoading;
  update();
}


  String menue = "home";
  String? subAdmin = "sub home";
  String adminName = "ADMIN NAME";
  String branchName = "BRANCH NAME";
  String? selectedBranchName;
  String? selectedBranchAddress;
  String? selectedBranchId;
  BranchModel? selectedBranch;
  List<AdminModel> allAdminList = [];

  changeObs(){
    psdObs = !psdObs;
    update();
  }

  changeMenue(String v) {
    menue = v;
    update();
  }

////////////////////// Depart Drop Down//////////////////////////////
  List<DropdownMenuItem<BranchModel>> buildBranchDropdownMenuItems(
      List<BranchModel> branchList) {
    print("branch list=${branchList.length}");
    List<DropdownMenuItem<BranchModel>> items = [];
    for (BranchModel branch in branchList) {
      items.add(
        DropdownMenuItem(
          value: branch,
          child: Text(branch.branchName!),
        ),
      );
    }
    print("item list=${items.length}");
    return items;
  }

  onBranchChangeDropdownItem(BranchModel? mySelectedBranch) {
    selectedBranch = mySelectedBranch;
    selectedBranchName = mySelectedBranch!.branchName;
    selectedBranchAddress = mySelectedBranch.branchAddress;
    selectedBranchId = mySelectedBranch.branchId;

    update();
  }

  /////////getsuperadminprofile///////
  OwnerProfileModel? model;

  http.Response? response;

  Future getOwnerProfileMethod() async {
    print("${StaticData.token}");
    response = await http.get(
      Uri.parse(StaticValues.getOwnerUrl),
      headers: <String, String>{
        'Content-type': 'application/json; charset=utf-8',
        "Authorization": " Bearer ${StaticData.token}"
      },
    );
    print("subadminstatus code--------- ${response!.statusCode}");
    if (response!.statusCode == 200) {
      print(
          ",,,,,,,,,,,,,,,,,,,store user list...........${response!.body.toString()}");
      model = OwnerProfileModel.fromJson(jsonDecode(response!.body));
      print(model);
      adminName = model!.data!.name!;
      print("admin name is --------------$adminName");
    }

    update();
  }
}
