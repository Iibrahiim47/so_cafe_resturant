import 'dart:convert';
import 'package:admin_panel_so/sub_admin/model/get_reviews_model.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../sub_admin/sub_admin_profile_controller/sub_admin_profile_controller.dart';

class GetReviewsController extends GetxController {
  static GetReviewsController get to => Get.find();

  http.Response? response;
  List<Data> allReviewsList = [];
  bool loading = false;

  Future<List<Data>> getReviewsMethod() async {
    allReviewsList.clear();
    print(
        "${StaticValues.getFeedbackUrl}${SubAdminProfileController.to.branchId}");
    response = await http.get(
      Uri.parse(
          "${StaticValues.getFeedbackUrl}${SubAdminProfileController.to.branchId}"),
      headers: {
        'Content-type': 'application/json; charset=utf-8',
      },
    );

    if (response!.statusCode == 200) {
      print(
          ",,,,,,,,,,,,,,,,,,,Reviews list...........${response!.body.toString()}");
      GetReviewsModel model =
          GetReviewsModel.fromJson(jsonDecode(response!.body));
      for (int i = 0; i < model.data!.length; i++) {
        Data d = model.data![i];
        allReviewsList.add(d);
      }
    }
    print(allReviewsList.length);
    update();
    return allReviewsList;
  }
}
