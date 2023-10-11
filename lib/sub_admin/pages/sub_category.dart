// ignore_for_file: avoid_print

import 'package:admin_panel_so/controller/branch_controller.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/sub_admin/model/get_category_model.dart';
import 'package:admin_panel_so/utils/flushbar.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_color.dart';
import '../../constant/media_qury.dart';
import '../../controller/menu_controller.dart';
import '../../super_admin/screens/pages/menue_page.dart';

class SubCategoryPage extends StatefulWidget {
  final int? branchId;
  const SubCategoryPage({super.key, this.branchId});

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController arabicController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final menuController = Get.put(MenuContreoller());
  clearcontroller() {
    nameController.clear();
    arabicController.clear();
  }

  @override
  void initState() {
    // CategoryGetandPostController.to.changeSelectImageStatus(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Category")),
      body: GetBuilder<CategoryGetandPostController>(builder: (obj) {
        return SizedBox(
            height: height,
            width: width,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.15,
                  width: width,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.01,
                      right: width * 0.01,
                    ),
                    child: Row(
                      children: [
                        obj.image == null
                            ? InkWell(
                                onTap: () {
                                  obj.addCategoryImage(context);
                                },
                                child: Container(
                                  height: height,
                                  width: width * 0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image),
                                      Text("Select Image")
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                height: height,
                                width: width * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        obj.image!.path,
                                      ),
                                    ),
                                    border: Border.all()),
                              ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: height,
                            width: width,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: height,
                                    width: width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: primary)),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: width * 0.02,
                                        ),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Required';
                                            }
                                            return null;
                                          },
                                          controller: nameController,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "ENTER English NAME"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Expanded(
                                  child: Container(
                                    height: height,
                                    width: width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: primary)),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: width * 0.02,
                                        ),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Required';
                                            }
                                            return null;
                                          },
                                          controller: arabicController,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "ENTER Arabic NAME"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Expanded(
                          child: Container(
                            height: height,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: primary)),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: width * 0.02,
                                  right: width * 0.02,
                                ),
                                child: DropdownButton(
                                  hint: const Text(
                                    'Select Category',
                                  ),
                                  items: obj.typeList.map((String items) {
                                    return DropdownMenuItem(
                                        value: items, child: Text(items));
                                  }).toList(),
                                  onChanged: (value) {
                                    // obj.changeCatoryType(value!);
                                  },
                                  value: obj.dropDownValue,
                                  underline: const SizedBox(),
                                  borderRadius: BorderRadius.circular(10),
                                  // items:
                                  //     categorydropdownMenuItems,
                                  isExpanded: true,
                                  // onChanged: obj
                                  //     .onCategoryChangeDropdownItem,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            height: height,
                            width: width * 0.2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextButton(
                              onPressed: () {
                                print(nameController.text);
                                print(arabicController.text);
                                print(obj.image);
                                if (formKey.currentState!.validate()) {
                                  // CategoryGetandPostController.to
                                  //     .uploadFooterItem(
                                  //   nameController.text,
                                  //   arabicController.text,
                                  // );
                                  // obj.addCategoryMethod(
                                  //     context,
                                  //     nameController.text,
                                  //     arabicController.text,
                                  //     obj.imageUrl!);
                                  clearcontroller();
                                  MyFlushBar.showSimpleFlushBar(
                                      "Added successfully",
                                      context,
                                      Colors.green,
                                      Colors.white);
                                } else {
                                  MyFlushBar.showSimpleFlushBar(
                                      "Fill All the fields",
                                      context,
                                      appSecondary,
                                      onSecondary);
                                }
                              },
                              child: Text(
                                "ADD Category",
                                style: TextStyle(
                                  color: appWhite,
                                  fontSize: width * 0.015,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                StreamBuilder(
                  stream: obj.fetchCatagoriesList().asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: GridView.builder(
                          gridDelegate: Responsive.isDesktop(context)
                              ? const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 200,
                              childAspectRatio: 0.8,
                              crossAxisCount: 6)
                              : const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => MenuPage(
                                  catgName: snapshot.data![index].araName,
                                  categId:
                                  snapshot.data![index].categoryId,
                                ));
                              },
                              child: Card(
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: SizedBox(
                                          width: mediaQueryWidth(context),
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              useOldImageOnUrlChange: true,
                                              imageUrl:
                                              "${StaticValues.imageUrl}${snapshot.data![index].imageUrl!}"),
                                        )),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            snapshot.data![index].araName!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: _text(text: "See Menu>>",color: appWhite,size: 14.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      const Center(child: CircularProgressIndicator());
                    }
                    return const Center(
                      child: Text('No Category found'),
                    );
                  },)
              ],
            ));
      }),
    );
  }

  Text _text({text, color, required double size}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: size),
    );
  }
}
