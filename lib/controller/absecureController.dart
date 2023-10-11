// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AbsecureTextController extends GetxController {
  static AbsecureTextController get to => Get.find();

  TextEditingController newpasswordcontroller = TextEditingController();
  TextEditingController oldpasswordcontroller = TextEditingController();

  bool isTexthide = true;

  absecureText() {
    isTexthide = !isTexthide;
    update();
  }
}
