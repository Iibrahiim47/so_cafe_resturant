import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/utils/theme.dart';
import 'package:flutter/material.dart';

import '../../constant/validator.dart';
import '../../utils/shared_widget/appTextField.dart';

class ForgorPassScreen extends StatefulWidget {
  const ForgorPassScreen({super.key});

  @override
  State<ForgorPassScreen> createState() => _ForgorPassScreenState();
}

class _ForgorPassScreenState extends State<ForgorPassScreen> {
  TextEditingController forgotEmailController = TextEditingController();
  TextEditingController forgotPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTextField(
            controller: forgotEmailController,
            label: 'Email',
            hint: 'example@gmail.com',
            borderColor: onPrimary,
            focusBorderColor: primary,
            autofillHints: const [AutofillHints.username],
            keyboardType: TextInputType.emailAddress,
            contentPadding: 10,
            borderRadius: 8,
            textInputAction: TextInputAction.next,
            validator: (value) {
              return Validation.emailValidation(value!);
            },
            isLabel: true,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
