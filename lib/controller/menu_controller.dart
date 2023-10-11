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

  deo.Dio dio = deo.Dio();
  bool isLoading2 = false;

  Future<void> pickGalleryImage() async {
    await imagePicker
        .pickImage(source: ImageSource.gallery)
        .then((value) => selectedImage = value);
  }




  Future<List<Data>> fetchProductList({categoryId}) async {
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
        List<Data> getProductListData = prodData.data ?? [];
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
    // try {
    //   if (selectedImage != null) {
    //     await selectedImage!.readAsBytes().then((value) async {
    //       deo.FormData data = deo.FormData.fromMap({
    //         "Image": deo.MultipartFile.fromBytes(value,
    //             filename: basename("${selectedImage!.path}.jpg")),
    //         "ARName": arbName,
    //         "EngName": engName,
    //         "CategoryType": selectedCategoryType,
    //         "BranchId": branchId
    //       });
    //
    //       var response = await dio.post(
    //         "${StaticValues.addProductUrl}$categoryId",
    //         data: data,
    //         options: Options(
    //           headers: <String, String>{
    //             "Content-type": "multipart/form-data",
    //             "Authorization": "Bearer ${StaticData.token}"
    //           },
    //         ),
    //       );
    //
    //       if (response.statusCode == 200) {
    //         if (response.data != null) {
    //           // You may want to handle the result here or return it, depending on your needs.
    //           print("Upload successful. Result: ${response.data}");
    //         }
    //       } else {
    //         throw Exception(
    //             "Failed to upload item. Status code: ${response.statusCode}");
    //       }
    //     });
    //   }
    // } catch (e) {
    //   print("Exception: $e");
    //   rethrow; // Re-throw the exception to handle it elsewhere if needed.
    // }
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
        // The product was deleted successfully.
      } else {
        throw Exception('Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting product: $e');
      throw Exception('Failed to delete product. Error: $e');
    }
  }

}
