import 'dart:convert';

import 'package:admin_panel_so/models/sub_order_model.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../model/get_category_model.dart';

class SubOrderController extends GetxController {
  static SubOrderController get to => Get.find();

  Future<List<Data>> fetchOrderAdmin(int? branchId) async {
    try {
      final response = await http.get(
        Uri.parse('${StaticValues.getOrdersAdmin}$branchId'),
        headers: {
          "Content-type": "application/json-patch+json",
          "Authorization": "Bearer ${StaticData.token}"
        },
      );

      if (response.statusCode == 200) {
        final orderData = SubOrderModel.fromJson(jsonDecode(response.body));

        List<Data> getsubOrderData = orderData.data ?? [];
        print('asadddddddyy${jsonEncode(getsubOrderData)}');

        return getsubOrderData;
      } else {
        throw Exception('Failed to fetch product list: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions here
      throw Exception('Failed to fetch product list: $e');
    }
  }
}
