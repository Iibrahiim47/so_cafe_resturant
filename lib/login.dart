import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/constant/media_qury.dart';
import 'package:admin_panel_so/constant/shared_pref.dart';
import 'package:admin_panel_so/constant/validator.dart';
import 'package:admin_panel_so/controller/login_controller/login_controller.dart';
import 'package:admin_panel_so/routes/routes_name.dart';
import 'package:admin_panel_so/super_admin/dashborad/admin_mianDashboard_screen.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/utils/shared_widget/appTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/flushbar.dart';

class AdminPannelLoginPage extends StatefulWidget {
  const AdminPannelLoginPage({super.key});

  @override
  State<AdminPannelLoginPage> createState() => _AdminPanelLoginPageState();
}

class _AdminPanelLoginPageState extends State<AdminPannelLoginPage> {
  final obj = Get.put(AdminLoginController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // obj.loginEmailController.text = "iibrahiim53@gmail.com";
    // obj.loginPassController.text = "12345678";
    obj.loginEmailController.text = "Mujahidsha127@gmail.com";
    obj.loginPassController.text = "123456";
    return Scaffold(body: Obx(() {
      return Stack(
        children: [
          Center(
              child: !Responsive.isDesktop(context)
                  ? SizedBox(
                      width: mediaQueryWidth(context) * 0.8,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text(
                              'Admin',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              'Login To Your Account',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppTextField(
                              controller: obj.loginEmailController,
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
                            AppTextField(
                              controller: obj.loginPassController,
                              label: 'Password',
                              hint: 'password',
                              psdObs: obj.psdObs.value,
                              borderColor: onPrimary,
                              focusBorderColor: primary,
                              autofillHints: const [AutofillHints.password],
                              keyboardType: TextInputType.visiblePassword,
                              contentPadding: 10,
                              borderRadius: 8,
                              obscuringCharacter: '*',
                              suffix: InkWell(
                                  borderRadius: BorderRadius.circular(25),
                                  onTap: () =>
                                      obj.psdObs.value = !obj.psdObs.value,
                                  child: obj.psdObs.value
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              textInputAction: TextInputAction.done,
                              validator: (value) =>
                                  Validation.validate(value!, 'password'),
                              isLabel: true,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {},
                                    child: const Text('forget password'))),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              width: mediaQueryWidth(context) * 0.5,
                              height: 40,
                              child: FilledButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    obj.loginMethod().then((value) {
                                      if (value.status ==
                                          "Login Successfully") {
                                        PreferencesService.saveUserModal(
                                            model: value);

                                        if (value.isAdmin == true) {
                                          Get.offAll(
                                              () => const AdminMainDashboard());
                                          MyFlushBar.showSimpleFlushBar(
                                              "Owner Login Successfully",
                                              context,
                                              Colors.green,
                                              Colors.white);
                                        } else {
                                          MyFlushBar.showSimpleFlushBar(
                                              "Admin Login Successfully",
                                              context,
                                              Colors.green,
                                              Colors.white);
                                          Get.offAllNamed(
                                              RoutesName.splash_screen);
                                        }
                                      } else {
                                        MyFlushBar.showSimpleFlushBar(
                                            "Login Failed",
                                            context,
                                            appSecondary,
                                            Colors.white);
                                      }
                                    });
                                  }
                                },
                                child: const Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      width: mediaQueryWidth(context) * 0.4,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Admin',
                              style: TextStyle(
                                fontSize: mediaQueryWidth(context) * 0.015,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Login To Your Account',
                              style: TextStyle(
                                fontSize: mediaQueryWidth(context) * 0.015,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            AppTextField(
                              controller: obj.loginEmailController,
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
                            AppTextField(
                              controller: obj.loginPassController,
                              label: 'Password',
                              hint: 'password',
                              psdObs: obj.psdObs.value,
                              borderColor: onPrimary,
                              focusBorderColor: primary,
                              autofillHints: const [AutofillHints.password],
                              keyboardType: TextInputType.visiblePassword,
                              contentPadding: 10,
                              borderRadius: 8,
                              obscuringCharacter: '*',
                              suffix: InkWell(
                                  borderRadius: BorderRadius.circular(25),
                                  onTap: () =>
                                      obj.psdObs.value = !obj.psdObs.value,
                                  child: obj.psdObs.value
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              textInputAction: TextInputAction.done,
                              validator: (value) =>
                                  Validation.validate(value!, 'password'),
                              isLabel: true,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {},
                                    child: const Text('forget password'))),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              width: mediaQueryWidth(context) * 0.2,
                              height: 40,
                              child: FilledButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    obj.loginMethod().then((value) async {
                                      if (value.status ==
                                          "Login Successfully") {
                                        PreferencesService.saveUserModal(
                                            model: value);

                                        if (value.isAdmin == true) {
                                          MyFlushBar.showSimpleFlushBar(
                                              "Owner Login Successfully",
                                              context,
                                              Colors.green,
                                              Colors.white);
                                          Get.offAll(
                                              () => const AdminMainDashboard());
                                        } else {
                                          MyFlushBar.showSimpleFlushBar(
                                              "Admin Login Successfully",
                                              context,
                                              Colors.green,
                                              Colors.white);

                                          Get.offAllNamed(
                                              RoutesName.splash_screen);
                                        }
                                      } else {
                                        MyFlushBar.showSimpleFlushBar(
                                            "Login Failed",
                                            context,
                                            appSecondary,
                                            Colors.white);
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          mediaQueryWidth(context) * 0.01),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
          if (obj.isLoading.value)
            Container(
              width: mediaQueryWidth(context),
              height: mediaQueryHeight(context),
              color: Colors.black.withOpacity(0.7),
              child: SizedBox(
                height: mediaQueryHeight(context) * 0.2,
                width: mediaQueryWidth(context) * 0.4,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      );
    }));
  }
}
