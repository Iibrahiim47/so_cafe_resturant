import 'package:admin_panel_so/constant/media_qury.dart';
import 'package:admin_panel_so/sub_admin/pages/sub_home/sub_home_controller.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/utils/shared_widget/appTextStyle.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/category_controller.dart';
import '../../../controller/menu_controller.dart';

class SubHomePage extends StatefulWidget {
  const SubHomePage({Key? key}) : super(key: key);

  @override
  State<SubHomePage> createState() => _SubHomePageState();
}

class _SubHomePageState extends State<SubHomePage> {
  final categObj = Get.put(CategoryGetandPostController());
  final menuObj = Get.put(MenuContreoller());
  @override
  void initState() {
    categObj
        .fetchCatagoriesList(branchId: StaticData.userProfile!.data!.branchId)
        .then((value) {
      menuObj.fetchProductList(categoryId: selectedCategory).then((value) {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubHomeController>(
      init: Get.put(SubHomeController()),
      builder: (obj) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: mediaQueryHeight(context)*0.05
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: AppTextStyle(
                    fontSize: Responsive.isDesktop(context) ?22:null,
                      marginHor: !Responsive.isDesktop(context) ?mediaQueryWidth(context) * 0.05 :null,
                      text: 'Categories')),
              StreamBuilder(
                stream: categObj
                    .fetchCatagoriesList(
                        branchId: StaticData.userProfile!.data!.branchId)
                    .asStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No data available');
                  } else {
                    return SizedBox(
                      width: mediaQueryWidth(context),
                      height: 100, // Adjust the height as needed
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: snapshot.data!.map((category) {
                            return Padding(
                                padding: const EdgeInsets.all(
                                    8.0), // Adjust the padding as needed
                                child: InkWell(
                                  onTap: () {
                                    menuObj
                                        .fetchProductList(
                                            categoryId: category.categoryId)
                                        .then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Column(children: [
                                    cachedNetworkImage(
                                        url: category.imageUrl.toString()),
                                    AppTextStyle(
                                      text: category.araName.toString(),
                                      fontSize: 10,
                                    )
                                  ]),
                                ));
                          }).toList())),
                    );
                  }
                },
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: AppTextStyle(
                      fontSize: Responsive.isDesktop(context) ?22:null,
                      marginHor: !Responsive.isDesktop(context) ?mediaQueryWidth(context) * 0.05 :null,
                      text: 'Menu')),
              menuObj.selectedProductList == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 170, mainAxisExtent: 170),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: menuObj.selectedProductList!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: mediaQueryWidth(context),
                                      child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${StaticValues.imageUrl}${menuObj.selectedProductList![index].imageUrl!}"),
                                    )),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    children: [
                                      Text(
                                        menuObj.selectedProductList![index]
                                            .engName!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
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
