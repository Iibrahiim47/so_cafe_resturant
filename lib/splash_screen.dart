import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:admin_panel_so/routes/routes_name.dart';
import 'package:admin_panel_so/sub_admin/model/sub_admin_profile_model.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getToken();
    getOwner();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("splash Screen");
    Future.delayed(const Duration(seconds: 2), () async {
      if (token.isNotEmpty && token != '') {
        StaticData.token = token;
        if (isAdmin) {
          Get.offAllNamed(RoutesName.admin_main_dashboard);
        } else if (!isAdmin) {
          await getUserProfile();
          Get.offAllNamed(RoutesName.sub_admin_dashboard);
        }
      } else {
        Get.offAllNamed(RoutesName.admin_login_page);
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

Future<void> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token') ?? '';
}

Future<void> getOwner() async {
  final prefs = await SharedPreferences.getInstance();
  isAdmin = prefs.getBool('isAdmin') ?? false;
}

Future<void> getUserProfile() async {
  const String apiUrl = 'https://api.socafe.cafe/api/UserApi/UserProfile';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer ${StaticData.token}',
      },
    );

    if (response.statusCode == 200) {
      StaticData.userProfile =
          SubAdminProfileModel.fromJson(jsonDecode(response.body));
      print('User Profile ${jsonEncode(StaticData.userProfile)}');
    } else {
      // Handle errors here (e.g., network error, API error)
      throw Exception('Failed to load user profile');
    }
  } catch (e) {
    // Handle any exceptions that occur during the HTTP request
    throw Exception('Error: $e');
  }
  return null;
}
