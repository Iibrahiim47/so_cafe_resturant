
import 'dart:ui';

import 'package:admin_panel_so/constant/app_color.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

void appToast({required String msg,required context}) {
  
  FlutterToastr.show(msg, context,
      duration: FlutterToastr.lengthLong,
      position:  FlutterToastr.bottom,
  );

}