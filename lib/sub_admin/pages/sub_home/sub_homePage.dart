import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/constant/media_qury.dart';
import 'package:admin_panel_so/sub_admin/pages/sub_home/sub_home_controller.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/utils/shared_widget/appTextField.dart';
import 'package:admin_panel_so/utils/shared_widget/appTextStyle.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/branch_controller.dart';
import '../../../controller/menu_controller.dart';

bool isClicked = false;

class SubHomePage extends StatefulWidget {
  const SubHomePage({super.key});

  @override
  State<SubHomePage> createState() => _SubHomePageState();
}

class _SubHomePageState extends State<SubHomePage> {
  final categObj = Get.put(CategoryGetandPostController());
  final menuObj = Get.put(MenuContreoller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubHomeController>(
      init: Get.put(SubHomeController()),
      builder: (obj) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              /// Responsive SearchBar
              Responsive.isMobile(context)
                  ? SizedBox(
                      height: kToolbarHeight,
                      width: mediaQueryWidth(context) * 0.8,
                      child: AppTextField(
                          prefixIcon: Icons.search,
                          hint: 'search here',
                          controller: TextEditingController(),
                          borderColor: onPrimary,
                          focusBorderColor: primary,
                          label: '',
                          borderRadius: 8,
                          isLabel: false),
                    )
                  : Responsive.isTablet(context)
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: kToolbarHeight,
                            width: mediaQueryWidth(context) * 0.4,
                            child: AppTextField(
                                prefixIcon: Icons.search,
                                hint: 'search here',
                                controller: TextEditingController(),
                                borderColor: onPrimary,
                                focusBorderColor: primary,
                                label: '',
                                borderRadius: 8,
                                isLabel: false),
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: mediaQueryWidth(context) * 0.3,
                            child: AppTextField(
                                prefixIcon: Icons.search,
                                hint: 'search here',
                                controller: TextEditingController(),
                                borderColor: onPrimary,
                                focusBorderColor: primary,
                                label: '',
                                borderRadius: 8,
                                isLabel: false),
                          ),
                        ),

              /// Categories
              /// StreamBuilder for Categories
              !Responsive.isDesktop(context)
                  ? Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextStyle(
                                marginHor: mediaQueryWidth(context) * 0.05,
                                text: 'Categories')),
                        StreamBuilder(
                          stream: categObj.fetchCatagoriesList(
                            branchId: StaticData.userProfile!.data!.branchId).asStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text('No data available');
                            } else {
                              return SizedBox(
                                height: 100, // Adjust the height as needed
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 150, // Adjust this to your item width
                                  ),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {

                                    return Column(
                                      children: [
                                        cachedNetworkImage(
                                          url: snapshot.data![index].imageUrl.toString(),
                                        ),
                                        AppTextStyle(
                                          text: snapshot.data![index].araName.toString(),
                                          fontSize: 10,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        )


                      ],
                    )
                  : const SizedBox(),

              !Responsive.isDesktop(context)
                  ? Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextStyle(
                                marginHor: mediaQueryWidth(context) * 0.05,
                                text: 'Menu')),
                      ],
                    )
                  : SizedBox()
            ],
          ),
        );
      },
    );
  }
}

cachedNetworkImage({required String url}) {
  return CachedNetworkImage(
    imageUrl: "${StaticValues.imageUrl}$url",
    imageBuilder: (context, imageProvider) => CircleAvatar(
      backgroundImage: imageProvider,
      radius: 30,
    ),
    filterQuality: FilterQuality.low,
    placeholder: (context, url) => const CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 30,
      child: Icon(
        Icons.image,
        color: Colors.white,
      ), // Adjust as needed
    ),
    errorWidget: (context, url, error) => const CircleAvatar(
      backgroundColor: Colors.red,
      radius: 30,
      child: Icon(Icons.error, color: Colors.white), // Adjust as needed
    ),
  );
}
