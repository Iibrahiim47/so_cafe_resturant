import 'dart:convert';
import 'package:admin_panel_so/sub_admin/model/get_reviews_model.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../sub_admin/sub_admin_profile_controller/sub_admin_profile_controller.dart';

class GetReviewsController extends GetxController {
  static GetReviewsController get to => Get.find();

  http.Response? response;
  bool loading = false;

  Future<List<Data>> getReviewsMethod() async {
    try {
      final response = await http.get(
        Uri.parse(
            "${StaticValues.getFeedbackUrl}${4}"),
        headers: {
          "Content-type": "application/json-patch+json",
          "Authorization": "Bearer ${StaticData.token}"
        },
      );

      if (response.statusCode == 200) {
        final catgData = GetReviewsModel.fromJson(jsonDecode(response.body));
        List<Data> getProductListData = catgData.data ?? [];
        return getProductListData;
      } else {
        // Handle error cases here
        throw Exception('Failed to fetch product list: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions here
      throw Exception('Failed to fetch product list: $e');
    }
  }
}
