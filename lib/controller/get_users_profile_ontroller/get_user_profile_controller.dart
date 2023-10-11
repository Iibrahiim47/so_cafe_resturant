import 'dart:async';
import 'dart:convert';

import 'package:admin_panel_so/models/get_users_model.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetuserProfileController extends GetxController {
  static GetuserProfileController get to => Get.find();

  http.Response? response;
  List<Data> ownerProfile = [];

  Future<List<Data>?> fetchUserProfileMethod() async {
    ownerProfile.clear();

    try {
      final result = await http.get(
        Uri.parse(StaticValues.getUserUrl),
        headers: <String, String>{
          'Content-type': 'application/json; charset=utf-8',
          "Authorization": " Bearer ${StaticData.token}"
        },
      );

      if (result.statusCode == 200) {
        final users = GetUsersProfile.fromJson(jsonDecode(result.body));
        if (users.data != null) {
          return users.data;
        }
      } else {
        // Handle error cases here
        throw Exception('Failed to fetch product list: ${result.statusCode}');
      }
    } catch (e) {
      // Handle exceptions here
      throw Exception('Failed to fetch product list: $e');
    }
    return null;
  }

}
