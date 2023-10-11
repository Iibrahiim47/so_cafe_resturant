import 'dart:convert';

import 'package:admin_panel_so/controller/get_branch_controller/get_branch_controller.dart';
import 'package:admin_panel_so/models/add_branch_model.dart';
import 'package:admin_panel_so/models/branch_model.dart';
import 'package:admin_panel_so/models/get_branches.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddBranchController extends GetxController {
  static AddBranchController get to => Get.find();

  bool isLoading2 = false;

  Future<void> deleteBranch(int branchId) async {
    http.Response response = await http.delete(
      Uri.parse(
          "${StaticValues.deleteBranch}$branchId"), // Replace with your DELETE endpoint
      headers: <String, String>{
        "Content-type": "application/json-patch+json",
        "Authorization": "Bearer ${StaticData.token}"
      },
    );
    print("Status code-- ${response.statusCode}");
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed To Load Model');
    }
  }

  Future<AddBranchModel> addBranchMethod(AddBranchModel model) async {
    print(StaticValues.addBranchUrl);
    http.Response response =
        await http.post(Uri.parse(StaticValues.addBranchUrl),
            headers: <String, String>{
              "Content-type": "application/json-patch+json",
              "Authorization": " Bearer ${StaticData.token}"
            },
            body: jsonEncode(model.toMap()));
    print("Status code-- ${response.statusCode}");
    print(response.body);
    if (response.statusCode == 200) {
      GetBranchListController.to.getBranchesMethod();

      return AddBranchModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed To Load Model');
    }
  }

  Future<bool> updateBranch({
    required int branchId,
    required String name,
    required String address,
  }) async {
    try {
      final Uri url = Uri.parse(StaticValues.updateBranchUrl);

      final Map<String, dynamic> requestBody = {
        "branchId": branchId,
        "name": name,
        "address": address,
      };

      final response = await http.post(url,
        headers: <String, String>{
          "Content-type": "application/json-patch+json",
          "Authorization": " Bearer ${StaticData.token}"
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Get.back();
        return true;
        print('Branch updated successfully');
      } else {
        //throw Exception('Failed to update branch: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle exceptions here
      //throw Exception('Failed to update branch: $e');
      return false;
    }
  }
}
