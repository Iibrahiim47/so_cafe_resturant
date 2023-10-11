import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/controller/get_reviews_controller/get_reviews_controller.dart';
import 'package:admin_panel_so/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubReviewsPage extends StatefulWidget {
  const SubReviewsPage({super.key});

  @override
  State<SubReviewsPage> createState() => _SubReviewsPageState();
}

class _SubReviewsPageState extends State<SubReviewsPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder<GetReviewsController>(initState: (state) {
        GetReviewsController.to.getReviewsMethod();
      }, builder: (obj) {
        return SizedBox(
          height: height,
          width: width,
          child: GridView.builder(
            itemCount: obj.allReviewsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  shadowColor: primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {},
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      height: height * 0.1,
                      width: width,
                      // color: Colors.amber,
                      child: Center(
                          child: Text(
                        '${obj.allReviewsList[index].name}',
                        style: TextStyle(
                          fontSize: width * 0.01,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
