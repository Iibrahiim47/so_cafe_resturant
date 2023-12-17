import 'package:admin_panel_so/constant/media_qury.dart';
import 'package:admin_panel_so/utils/shared_widget/appTextField.dart';
import 'package:admin_panel_so/utils/shared_widget/appTextStyle.dart';
import 'package:flutter/material.dart';

import '../../constant/app_color.dart';
import '../../utils/static_data.dart';

class SubProfilePage extends StatefulWidget {
  const SubProfilePage({super.key});

  @override
  State<SubProfilePage> createState() => _SubProfilePageState();
}

class _SubProfilePageState extends State<SubProfilePage> {
  @override
  Widget build(BuildContext context) {
    bool enabled = false;
    return Scaffold(
      appBar: AppBar(
        title: const AppTextStyle(text: ""),
      ),
      body: Column(
        children: [
          SizedBox(
            height: mediaQueryHeight(context) * 0.07,
          ),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: AppTextStyle(
                      text:
                          StaticData.userProfile!.data!.name![0].toUpperCase() +
                              StaticData.userProfile!.data!.name![1],
                      fontSize: 20),
                ),
                SizedBox(
                  height: mediaQueryHeight(context) * 0.02,
                ),
                SizedBox(
                  height: kToolbarHeight,
                  width: mediaQueryWidth(context) * 0.8,
                  child: AppTextField(
                      enabled: enabled,
                      prefixIcon: Icons.phone,
                      hint: StaticData.userProfile!.data!.email.toString(),
                      controller: TextEditingController(),
                      borderColor: onPrimary,
                      focusBorderColor: primary,
                      label: '',
                      borderRadius: 8,
                      isLabel: false),
                ),
                SizedBox(
                  height: kToolbarHeight,
                  width: mediaQueryWidth(context) * 0.8,
                  child: AppTextField(
                      enabled: enabled,
                      prefixIcon: Icons.person,
                      hint: StaticData.userProfile!.data!.name.toString(),
                      controller: TextEditingController(),
                      borderColor: onPrimary,
                      focusBorderColor: primary,
                      label: '',
                      borderRadius: 8,
                      isLabel: false),
                ),
                SizedBox(
                  height: kToolbarHeight,
                  width: mediaQueryWidth(context) * 0.8,
                  child: AppTextField(
                      enabled: enabled,
                      prefixIcon: Icons.phone,
                      hint:
                          StaticData.userProfile!.data!.phoneNumber.toString(),
                      controller: TextEditingController(),
                      borderColor: onPrimary,
                      focusBorderColor: primary,
                      label: '',
                      borderRadius: 8,
                      isLabel: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
