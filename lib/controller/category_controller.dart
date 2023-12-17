// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:admin_panel_so/models/branch_model.dart';
import 'package:admin_panel_so/sub_admin/model/get_category_model.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as deo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CategoryGetandPostController extends GetxController {
  static CategoryGetandPostController get to => Get.find();
  http.Response? response;
  XFile? image;
  final ImagePicker imagePicker = ImagePicker();
  List<BranchModel> allBranchesList = [];
  int? categoryId;
  int selectedCategoryType = 0;
  String dropDownValue = "Food";
  var typeList = ["Food", "Drinks"];
  bool isLoading2 = false;
  XFile? selectedImage;
  deo.Dio dio = deo.Dio();

  changeCategoryType(String value) {
    dropDownValue = value;
    if (value == "Food") {
      selectedCategoryType = 1;
    } else {
      selectedCategoryType = 2;
    }
    update();
  }

  Future<void> pickGalleryImage() async {
    await imagePicker
        .pickImage(source: ImageSource.gallery)
        .then((value) => selectedImage = value);
  }

  Future<void> addNewCategory(
      {int? branchId, String? arbName, String? engName}) async {
    try {
      if (selectedImage != null) {
        await selectedImage!.readAsBytes().then((value) async {
          deo.FormData data = deo.FormData.fromMap({
            "Image": deo.MultipartFile.fromBytes(value,
                filename: basename("${selectedImage!.path}.jpg")),
            "ARName": arbName,
            "EngName": engName,
            "CategoryType": selectedCategoryType,
            "BranchId": branchId
          });

          var response = await dio.post(
            "https://api.socafe.cafe/api/Categories/AddCategory",
            data: data,
            options: Options(
              headers: <String, String>{
                "Content-type": "multipart/form-data",
                "Authorization": "Bearer ${StaticData.token}"
              },
            ),
          );

          if (response.statusCode == 200) {
            if (response.data != null) {
              // You may want to handle the result here or return it, depending on your needs.
            }
          } else {
            throw Exception(
                "Failed to upload item. Status code: ${response.statusCode}");
          }
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  //////////getCategories///////////

  Future<List<DataList>> fetchCatagoriesList({int? branchId}) async {
    try {
      final response = await http.get(
        Uri.parse("${StaticValues.getAllCategoryUrl}$branchId"),
        headers: {
          "Content-type": "application/json-patch+json",
          "Authorization": "Bearer ${StaticData.token}"
        },
      );

      if (response.statusCode == 200) {
        final catgData =
            GetCatagoryListModel.fromJson(jsonDecode(response.body));
        List<DataList> getCategoryData = catgData.data ?? [];
        selectedCategory = getCategoryData[0].categoryId!.toInt();
        return getCategoryData;
      } else {
        // Handle error cases here
        throw Exception('Failed to fetch product list: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions here
      throw Exception('Failed to fetch product list: $e');
    }
  }

  /////////////deletecategory/////////
  Future<void> deleteCategoryMethod({required int categoryId}) async {
    try {
      final response = await http.delete(
        Uri.parse("${StaticValues.deleteCategoryUrl}$categoryId"),
        headers: <String, String>{
          "Content-type": "application/json-patch+json",
          "Authorization": "Bearer ${StaticData.token}"
        },
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Failed to delete category. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete category. Error: $e');
    }
  }

  void addCategoryImage(BuildContext context) {}

  Future<String> updateCategoryIndex({required int categoryId, required int newIndex}) async {
    final url = Uri.parse('https://api.socafe.cafe/api/Categories/UpdateCategoryIndex');

    final headers = {
      'Authorization': 'Bearer ${StaticData.token}',
      'Content-Type': 'application/json-patch+json',
    };

    final data = [
      {
        "id": categoryId,
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
        return "updated successfully";
      } else {
        throw Exception('Failed to update category index. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return 'Error: $e';
    }
  }



  Future<bool> updateCategory({
    required int categoryId,
    required String engName,
    required String arName,
  }) async {
      const String updateApi = 'https://api.socafe.cafe/api/Categories/UpdateCategory';

      try {
        if (selectedImage != null) {
          await selectedImage!.readAsBytes().then((value) async {
            deo.FormData data = deo.FormData.fromMap({
              "categoryId": categoryId,
              "arName": arName,
              "engName": engName,
              "image": deo.MultipartFile.fromBytes(value,
                  filename: basename("${selectedImage!.path}.jpg")),
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
