import 'dart:convert';

import 'package:admin_panel_so/models/signup_model.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  static SignUpController get to => Get.find();

  userSignUPMethiod(SignupResponseModel model) async {
    http.Response response =
        await http.post(Uri.parse(StaticValues.userSignUpUrl),
            headers: <String, String>{
              "Content-type": " application/json-patch+json",
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
