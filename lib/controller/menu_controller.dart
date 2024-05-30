// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:admin_panel_so/sub_admin/model/get_product_model.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:dio/dio.dart' as deo;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class MenuContreoller extends GetxController {
  static MenuContreoller get to => Get.find();

  http.Response? response;
  XFile? selectedImage;
  final ImagePicker imagePicker = ImagePicker();
  List<Data>? selectedProductList;
  deo.Dio dio = deo.Dio();
  bool isLoading2 = false;

  Future<void> pickGalleryImage() async {
    await imagePicker
        .pickImage(source: ImageSource.gallery)
        .then((value) => selectedImage = value);
  }

///////getproducts//////////
  List<Data> getProductListData = [];
  Future<List<Data>> fetchProductList({categoryId}) async {
    getProductListData.clear();
    try {
      final response = await http.get(
        Uri.parse("${StaticValues.getproducteUrl}$categoryId"),
        headers: {
          "Content-type": "application/json-patch+json",
          "Authorization": "Bearer ${StaticData.token}"
        },
      );

      if (response.statusCode == 200) {
        final prodData = GetProductModel.fromJson(jsonDecode(response.body));
        getProductListData = prodData.data ?? [];
        selectedProductList = getProductListData;
        update();
        print("Menu List ${jsonEncode(selectedProductList)}");
        print("selected category...............$selectedCategory");
        print("${getProductListData.first.engName}");
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

  Future<void> addNewProduct(
      {String? arbName,
      String? engName,
      String? description,
      double? price,
      int? categoryId}) async {
    try {
      if (selectedImage != null) {
        await selectedImage!.readAsBytes().then((value) async {
          deo.FormData data = deo.FormData.fromMap({
            "Image": deo.MultipartFile.fromBytes(value,
                filename: basename("${selectedImage!.path}.jpg")),
            "AraName": arbName,
            "EngName": engName,
            "Description": description,
            "Price": price,
            "CategoryId": categoryId,
          });

          var response = await dio.post(
            StaticValues.addProductUrl,
            data: data,
            options: Options(
              headers: <String, String>{
                "Content-type": "multipart/form-data",
                "Authorization": "Bearer ${StaticData.token}"
              },
            ),
          );

          if (response.statusCode == 200) {
            update();
            if (response.data != null) {
              // You may want to handle the result here or return it, depending on your needs.
              print("Upload successful. Result: ${response.data}");
            }
          } else {
            throw Exception(
                "Failed to upload item. Status code: ${response.statusCode}");
          }
        });
      }
    } catch (e) {
      print("Exception: $e");
      rethrow; // Re-throw the exception to handle it elsewhere if needed.
    }
  }

  Future<void> deleteProduct({required int productId}) async {
    try {
      final response = await http.delete(
        Uri.parse("${StaticValues.deleteProductUrl}$productId"),
        headers: {
          "Content-type": "application/json-patch+json",
          "Authorization": "Bearer ${StaticData.token}"
        },
      );

      if (response.statusCode == 200) {
        update();
        // The product was deleted successfully.
      } else {
        throw Exception(
            'Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting product: $e');
      throw Exception('Failed to delete product. Error: $e');
    }
  }

  Future<String> updateProductIndex(
      {required int productId, required int newIndex}) async {
    final url =
        Uri.parse('https://api.socafe.cafe/api/Product/UpdateProductIndex');

    final headers = {
      'Authorization': 'Bearer ${StaticData.token}',
      'Content-Type': 'application/json-patch+json',
    };

    final data = [
      {
        "id": productId,
        "index": newIndex,
      }
    ];

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        update();
        return "updated successfully";
      } else {
        throw Exception(
            'Failed to update product index: ${response.statusCode}');
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<bool> updateProduct({
    String? engName,
    String? arbName,
    String? description,
    double? price,
    int? categoryId,
    int? productId,
  }) async {
    const String updateApi =
        'https://api.socafe.cafe/api/Product/UpdateProduct';

    try {
      if (selectedImage != null) {
        await selectedImage!.readAsBytes().then((value) async {
          deo.FormData data = deo.FormData.fromMap({
            "Image": deo.MultipartFile.fromBytes(value,
                filename: basename("${selectedImage!.path}.jpg")),
            'ProductId': productId,
            'EngName': engName,
            'AraName': arbName,
            'Description': description,
            'Price': price,
            'CategoryId': categoryId,
          });

          var response = await dio.post(
            updateApi,
            data: data,
            options: Options(
              headers: <String, String>{
                "Content-type": "multipart/form-data",
                "Authorization": "Bearer ${StaticData.token}",
              },
            ),
          );

          if (response.statusCode == 200) {
            update();
            print(response.statusCode);
            return true;
          }
        });
      }
    } catch (e) {
      print(e);
      return false;
    }

    return false;
  }
}
