import 'dart:convert';

import 'package:admin_panel_so/models/login_model.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/static_data.dart';

class AdminLoginController extends GetxController {
  static AdminLoginController get to => Get.find();

  RxBool psdObs = true.obs;
  RxBool isLoading = false.obs;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();

  Future<LoginResponse> loginMethod() async {
    isLoading.value = true;
    try {
      final model = LoginReqModel(
        email: loginEmailController.text,
        password: loginPassController.text,
      );

      final response = await http.post(
        Uri.parse(StaticValues.userLoginUrl),
        headers: <String, String>{
          "Content-type": "application/json-patch+json"
        },
        body: jsonEncode(model.toMap()),
      );

      if (response.statusCode == 200) {
        print('Login User Info ${response.body}');
        isLoading.value = false;
        return LoginResponse.fromMap(jsonDecode(response.body));
      } else {
        isLoading.value = false;
        Get.snackbar('Failed To Login', '');
        throw Exception('Failed To Load Model');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Failed To Login', e.toString());
      rethrow;
    }
  }

}
