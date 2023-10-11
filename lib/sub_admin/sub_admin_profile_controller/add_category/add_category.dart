import 'dart:convert';

import 'package:admin_panel_so/models/signup_model.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddCategoryController extends GetxController {
  static AddCategoryController get to => Get.find();

  Future<SignupResponseModel> addadminMethiod(SignupResponseModel model) async {
    print(StaticValues.addCategoryUrl);
    http.Response response =
        await http.post(Uri.parse(StaticValues.addCategoryUrl),
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
}
