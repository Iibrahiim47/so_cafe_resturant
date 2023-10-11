import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/utils/theme.dart';
import 'package:flutter/material.dart';

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
      body: Container(
        height: height,
        width: width,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.cover,
        //     image: AssetImage(
        //       'images/bg.jpg',
        //     ),
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * 0.15,
              width: width * 0.2,
              // color: Colors.amber,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'images/logo.png',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
              width: width * 0.2,
              // color: Colors.amber,
              child: Center(
                child: Text(
                  'Request New Password',
                  style: TextStyle(
                    fontSize: width * 0.015,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.4,
              width: width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: height,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: Container(
                              height: height * 0.07,
                              width: width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: primary)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: forgotEmailController,
                                  cursorColor: primary,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter Your Email",
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: primary,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: InkWell(
                              onTap: () {
                                // if (loginEmailController.isBlank! ||
                                //     loginPassController.isBlank!) {
                                //   MyFlushBar.showSimpleFlushBar(
                                //       "Fill All the fields",
                                //       context,
                                //       AdminTheme.errorColor,
                                //       AdminTheme.secondryColor);
                                // } else {
                                //   obj.adminLoginMethod(
                                //       loginEmailController.text,
                                //       loginPassController.text,
                                //       context);
                                // }
                              },
                              child: Container(
                                  height: height * 0.07,
                                  width: width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: primary),
                                  child: Text(
                                    "Request New Passord",
                                    style: TextStyle(
                                        color: appWhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.015),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
