import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/controller/get_reviews_controller/get_reviews_controller.dart';
import 'package:admin_panel_so/sub_admin/model/get_reviews_model.dart';
import 'package:admin_panel_so/utils/rating_star.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/media_qury.dart';
import '../../utils/responsive.dart';
import '../../utils/shared_widget/appTextStyle.dart';

class GetReviewsPage extends StatefulWidget {
  const GetReviewsPage({super.key});

  @override
  State<GetReviewsPage> createState() => _GetReviewsPageState();
}

class _GetReviewsPageState extends State<GetReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<GetReviewsController>(
      init: Get.put(GetReviewsController()),
      builder: (obj) {
        return Column(
          children: [
            Responsive.isDesktop(context) ?Align(
                alignment: Alignment.centerLeft,
                child: AppTextStyle(
                    marginVer: 10,
                    fontSize: Responsive.isDesktop(context) ?22:null,
                    marginHor: !Responsive.isDesktop(context) ?mediaQueryWidth(context) * 0.05 :null,
                    text: 'Reviews')) : SizedBox(),
            Responsive.isDesktop(context) ?SizedBox(height: kToolbarHeight,) :SizedBox(),

            Expanded(
              child: StreamBuilder<List<Data>>(
                stream: obj.getReviewsMethod().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Handle the case where data is still loading
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Handle the case where an error occurred
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                    // Handle the case where there is no data or empty data
                    return const Center(child: Text('No reviews.'));
                  } else {
                    // Data is available, build the list
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: snapshot.data!.map((reviews) {
                          return SizedBox(
                            height: 80,
                            child: InkWell(
                              onTap: () {
                                Get.defaultDialog(
                                  title: reviews.email.toString(),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Name:  ${reviews.name?.toUpperCase() ?? 'N/A'}"),
                                      Text("Phone:  ${reviews.phoneNumber?.toString() ?? 'N/A'}"),
                                      Text("about us:  ${reviews.aboutus?.toString() ?? 'N/A'}"),
                                      Text("City:  ${reviews.city ?? 'N/A'}"),
                                      Text("improve:  ${reviews.improve?.toString() ?? 'N/A'}"),
                                      Text("firstTime:  ${reviews.firstTime?.toString() ?? 'N/A'}"),
                                      Text("DateTime:  ${reviews.registrationDateTime?.toString() ?? 'N/A'}"),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("ServiceRating"),
                                          RatingStar(
                                            rating: reviews.serviceRating?.toDouble() ?? 0.0,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("StaffRating"),
                                          RatingStar(
                                            rating: reviews.staffRating?.toDouble() ?? 0.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: primary,
                                      child: AppTextStyle(
                                        text: reviews.name![0] + reviews.name![1],
                                        textColor: appWhite,
                                        fontSize: 18,
                                      ),
                                    ),
                                    title: AppTextStyle(
                                      text: reviews.name?.toString().toUpperCase() ?? 'N/A',
                                    ),
                                    subtitle: AppTextStyle(
                                      text: reviews.email?.toString() ?? 'N/A',
                                      textColor: primary,
                                      fontSize: 12,
                                    ),
                                    titleAlignment: ListTileTitleAlignment.center,
                                    trailing: RatingStar(
                                      rating: reviews.serviceRating?.toDouble() ?? 0.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    ));
  }
}