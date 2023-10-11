
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../constant/media_qury.dart';
import '../../../login.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text("Setting"),
          ),
          const Divider(),
          SizedBox(
            height: mediaQueryHeight(context) * 0.1,
          ),
          Expanded(
              child: Center(
                  child: FilledButton(
                    onPressed: logout,
                    child: const Text('Logout'),
                  )))
        ],
      ),
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    StaticData.token ='';
    Get.offAll(const AdminPannelLoginPage());
  }
}
