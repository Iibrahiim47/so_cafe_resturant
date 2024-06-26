import 'dart:io';
import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/controller/category_controller.dart';
import 'package:admin_panel_so/sub_admin/model/get_category_model.dart';
import 'package:admin_panel_so/super_admin/screens/pages/menue_page.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import '../../../../../constant/media_qury.dart';
import '../../../../../controller/menu_controller.dart';
import '../../../constant/validator.dart';
import '../../../utils/app_toast.dart';
import '../../../utils/flushbar.dart';
import '../../../utils/shared_widget/appTextField.dart';
import '../../utils/shared_widget/appTextStyle.dart';

class SubMenuPage extends StatefulWidget {
  final int? branchId;
  const SubMenuPage({super.key, this.branchId});

  @override
  State<SubMenuPage> createState() => _SubMenuPageState();
}

class _SubMenuPageState extends State<SubMenuPage> {
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
    Get.put(CategoryGetandPostController());
    CategoryGetandPostController.to
        .fetchCatagoriesList(branchId: StaticData.userProfile!.data!.branchId);
    super.initState();
  }

  rebuild() {
    setState(() {});
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<CategoryGetandPostController>(builder: (categObj) {
        return SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Responsive.isDesktop(context)
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextStyle(
                          marginVer: 10,
                          fontSize: Responsive.isDesktop(context) ? 22 : null,
                          marginHor: !Responsive.isDesktop(context)
                              ? mediaQueryWidth(context) * 0.05
                              : null,
                          text: 'Menu'))
                  : const SizedBox(),
              Responsive.isDesktop(context)
                  ? const SizedBox(
                      height: kToolbarHeight,
                    )
                  : const SizedBox(),
              Expanded(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: ReorderableGridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    onReorder: (int oldIndex, int newIndex) {
                      print(oldIndex);
                      print(
                          "------------------------------------------this is old index");
                      print(newIndex);
                      print(
                          "------------------------------------------this is new index");
                      int oldCategoryId =
                          categObj.allCategoriesList[oldIndex].categoryId!;
                      int newCategoryId =
                          categObj.allCategoriesList[newIndex].categoryId!;
                      categObj.updateCategoriesIndex(
                          catID: oldCategoryId, newIndex: newIndex);
                      categObj
                          .updateCategoriesIndex(
                              catID: newCategoryId, newIndex: oldIndex)
                          .then((value) {
                        categObj.fetchCatagoriesList(
                            branchId: StaticData.userProfile!.data!.branchId);
                      });

                      // setState(() {
                      //   if (newIndex > oldIndex) {
                      //     newIndex -= 1;
                      //   }
                      //   final element = snapshot.data!.removeAt(oldIndex);
                      //   snapshot.data!.insert(newIndex, element);
                      // });
                    },
                    itemCount: categObj.allCategoriesList.length,
                    itemBuilder: (context, index) {
                      // final String productName = snapshot.data![index].engName!;
                      return Padding(
                        key: Key(categObj.allCategoriesList[index].engName!),
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          // key: Key("$index"),
                          onTap: () {
                            Get.to(() => MenuPage(
                                  catgName:
                                      categObj.allCategoriesList[index].araName,
                                  categId: categObj
                                      .allCategoriesList[index].categoryId,
                                ));
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: popUp(
                                        modal:
                                            categObj.allCategoriesList[index])),
                                Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      key: const Key("Const"),
                                      width: mediaQueryWidth(context),
                                      child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          fit: BoxFit.cover,
                                          useOldImageOnUrlChange: true,
                                          imageUrl:
                                              "${StaticValues.imageUrl}${categObj.allCategoriesList[index].imageUrl!}"),
                                    )),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    children: [
                                      Text(
                                        categObj
                                            .allCategoriesList[index].araName!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      _text(
                                          text: "See Menu>>",
                                          color: appWhite,
                                          size: 14.0)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  scrollable: true,
                  title: const Text("New Category"),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => CategoryGetandPostController.to
                              .pickGalleryImage()
                              .then((_) {
                            setState(() {});
                          }),
                          child: Container(
                            constraints: BoxConstraints(
                                maxHeight: mediaQueryHeight(context) * 0.3,
                                minHeight: mediaQueryHeight(context) * 0.1,
                                minWidth: mediaQueryWidth(context) * 0.32),
                            child: Card(
                              color: appGrey.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the radius as needed
                              ),
                              child: CategoryGetandPostController
                                          .to.selectedImage !=
                                      null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          10), // Apply the same radius as the Card
                                      child: Image.file(
                                        File(CategoryGetandPostController
                                            .to.selectedImage!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                          Icon(Icons.image, size: 35),
                                          Text('No Image')
                                        ]),
                            ),
                          ),
                        ),
                        CategoryGetandPostController.to.selectedImage == null
                            ? const Text('Tap to pick image')
                            : const SizedBox(),
                        AppTextField(
                          controller: nameController,
                          label: 'Category',
                          hint: 'category name',
                          filled: true,
                          fillColor: appGrey.withOpacity(0.2),
                          borderColor: appGrey.withOpacity(0.2),
                          focusBorderColor: appGrey.withOpacity(0.2),
                          autofillHints: const [AutofillHints.nameSuffix],
                          keyboardType: TextInputType.name,
                          contentPadding: 10,
                          borderRadius: 8,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            return Validation.validate(value!, 'category name');
                          },
                          isLabel: true,
                        ),
                        AppTextField(
                          controller: arabicController,
                          label: 'Description',
                          hint: 'category detail',
                          filled: true,
                          fillColor: appGrey.withOpacity(0.2),
                          borderColor: appGrey.withOpacity(0.2),
                          focusBorderColor: appGrey.withOpacity(0.2),
                          autofillHints: const [AutofillHints.nameSuffix],
                          keyboardType: TextInputType.name,
                          contentPadding: 10,
                          borderRadius: 8,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            return Validation.validate(value!, 'category name');
                          },
                          isLabel: true,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        CategoryGetandPostController.to.selectedImage = null;
                        clearcontroller();
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          CategoryGetandPostController.to.isLoading2 = true;
                        });

                        CategoryGetandPostController.to
                            .addNewCategory(
                                branchId:
                                    StaticData.userProfile!.data!.branchId,
                                engName: nameController.text,
                                arbName: arabicController.text)
                            .then((value) {
                          setState(() {
                            rebuild();
                            CategoryGetandPostController.to.isLoading2 = false;
                            Navigator.pop(context);
                            clearcontroller();
                            appToast(msg: 'Branch Added', context: context);
                          });
                        });
                      },
                      child: CategoryGetandPostController.to.isLoading2 == false
                          ? const Text("Save")
                          : const CircularProgressIndicator(),
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: primary,
          child: const Icon(Icons.add)),
    );
  }

  popUp({required DataList modal}) {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 0) {
          Get.defaultDialog(
            title: "Are You Sure?",
            content: const Text("Item will never restore"),
            cancel: TextButton(
                onPressed: () => Get.back(), child: const Text('No')),
            confirm: TextButton(
                onPressed: () {
                  CategoryGetandPostController.to
                      .deleteCategoryMethod(categoryId: modal.categoryId!)
                      .then((value) {
                    setState(() {
                      rebuild();
                      Get.back();
                      appToast(msg: 'Category deleted', context: context);
                    });
                  });
                },
                child: const Text('Yes')),
          );
        } else if (value == 1) {
          updateCategory(
              engName: modal.engName,
              araName: modal.araName,
              categoryId: modal.categoryId,
              imageUrl: modal.imageUrl);
        }
      },
      color: appBlack,
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
              value: 0,
              child: Row(
                children: [Icon(Icons.delete), Text('delete')],
              )),
          const PopupMenuItem(
              value: 1,
              child: Row(
                children: [Icon(Icons.update), Text('update')],
              )),
        ];
      },
      child: const Icon(Icons.more_vert, color: appWhite),
    );
  }

  // addCategory() {
  //   showGeneralDialog(
  //       context: context,
  //       pageBuilder: (BuildContext buildContext, Animation<double> animation,
  //           Animation<double> secondaryAnimation) {
  //         return StatefulBuilder(
  //           builder: (context, setState) {
  //             return AlertDialog.adaptive(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8)),
  //               scrollable: true,
  //               title: const Text("New Category"),
  //               content: SingleChildScrollView(
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     InkWell(
  //                       onTap: () => CategoryGetandPostController.to
  //                           .pickGalleryImage()
  //                           .then((_) {
  //                         setState(() {});
  //                       }),
  //                       child: Container(
  //                         constraints: BoxConstraints(
  //                             maxHeight: mediaQueryHeight(context) * 0.3,
  //                             minHeight: mediaQueryHeight(context) * 0.1,
  //                             minWidth: mediaQueryWidth(context) * 0.32),
  //                         child: Card(
  //                           color: appGrey.withOpacity(0.5),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(
  //                                 10), // Adjust the radius as needed
  //                           ),
  //                           child:
  //                               CategoryGetandPostController.to.selectedImage !=
  //                                       null
  //                                   ? ClipRRect(
  //                                       borderRadius: BorderRadius.circular(
  //                                           10), // Apply the same radius as the Card
  //                                       child: Image.file(
  //                                         File(CategoryGetandPostController
  //                                             .to.selectedImage!.path),
  //                                         fit: BoxFit.cover,
  //                                       ),
  //                                     )
  //                                   : const Column(
  //                                       mainAxisSize: MainAxisSize.min,
  //                                       children: [
  //                                           Icon(Icons.image, size: 35),
  //                                           Text('No Image')
  //                                         ]),
  //                         ),
  //                       ),
  //                     ),
  //                     CategoryGetandPostController.to.selectedImage == null
  //                         ? const Text('Tap to pick image')
  //                         : const SizedBox(),
  //                     AppTextField(
  //                       controller: nameController,
  //                       label: 'Category',
  //                       hint: 'category name',
  //                       filled: true,
  //                       fillColor: appGrey.withOpacity(0.2),
  //                       borderColor: appGrey.withOpacity(0.2),
  //                       focusBorderColor: appGrey.withOpacity(0.2),
  //                       autofillHints: const [AutofillHints.nameSuffix],
  //                       keyboardType: TextInputType.name,
  //                       contentPadding: 10,
  //                       borderRadius: 8,
  //                       textInputAction: TextInputAction.next,
  //                       validator: (value) {
  //                         return Validation.validate(value!, 'category name');
  //                       },
  //                       isLabel: true,
  //                     ),
  //                     AppTextField(
  //                       controller: arabicController,
  //                       label: 'Description',
  //                       hint: 'category detail',
  //                       filled: true,
  //                       fillColor: appGrey.withOpacity(0.2),
  //                       borderColor: appGrey.withOpacity(0.2),
  //                       focusBorderColor: appGrey.withOpacity(0.2),
  //                       autofillHints: const [AutofillHints.nameSuffix],
  //                       keyboardType: TextInputType.name,
  //                       contentPadding: 10,
  //                       borderRadius: 8,
  //                       textInputAction: TextInputAction.next,
  //                       validator: (value) {
  //                         return Validation.validate(value!, 'category name');
  //                       },
  //                       isLabel: true,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               actions: <Widget>[
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     CategoryGetandPostController.to.selectedImage = null;
  //                     clearcontroller();
  //                   },
  //                   child: const Text("Cancel"),
  //                 ),
  //                 TextButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       CategoryGetandPostController.to.isLoading2 = true;
  //                     });

  //                     CategoryGetandPostController.to
  //                         .addNewCategory(
  //                             branchId: StaticData.userProfile!.data!.branchId,
  //                             engName: nameController.text,
  //                             arbName: arabicController.text)
  //                         .then((value) {
  //                       setState(() {
  //                         rebuild();
  //                         CategoryGetandPostController.to.isLoading2 = false;
  //                         Navigator.pop(context);
  //                         clearcontroller();
  //                         appToast(msg: 'Branch Added', context: context);
  //                       });
  //                     });
  //                   },
  //                   child: CategoryGetandPostController.to.isLoading2 == false
  //                       ? const Text("Save")
  //                       : const CircularProgressIndicator(),
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       });
  // }

  void updateCategory(
      {String? engName, String? araName, int? categoryId, String? imageUrl}) {
    setState(() {
      nameController.text = engName.toString();
      arabicController.text = araName.toString();
    });
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog.adaptive(
              title: const Text("Update Category"),
              content: SizedBox(
                width: !Responsive.isMobile(context)
                    ? mediaQueryWidth(context) * 0.3
                    : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => CategoryGetandPostController.to
                        ..pickGalleryImage().then((_) {
                          setState(() {});
                        }),
                      child: Container(
                        constraints: BoxConstraints(
                            maxHeight: mediaQueryHeight(context) * 0.3,
                            minHeight: mediaQueryHeight(context) * 0.1,
                            minWidth: mediaQueryWidth(context) * 0.32),
                        child: Card(
                          color: appGrey.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                          ),
                          child:
                              CategoryGetandPostController.to.selectedImage !=
                                      null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          10), // Apply the same radius as the Card
                                      child: Image.file(
                                        File(CategoryGetandPostController
                                            .to.selectedImage!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                          Icon(Icons.image, size: 35),
                                          Text('No Image')
                                        ]),
                        ),
                      ),
                    ),
                    CategoryGetandPostController.to.selectedImage == null
                        ? const Text('Tap to pick image')
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: nameController,
                      label: 'Name',
                      hint: 'name',
                      filled: true,
                      fillColor: appGrey.withOpacity(0.2),
                      borderColor: appGrey.withOpacity(0.2),
                      focusBorderColor: appGrey.withOpacity(0.2),
                      autofillHints: const [AutofillHints.addressCityAndState],
                      keyboardType: TextInputType.streetAddress,
                      contentPadding: 10,
                      borderRadius: 8,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return Validation.validate(value!, 'name');
                      },
                      isLabel: true,
                    ),
                    AppTextField(
                      controller: arabicController,
                      label: 'Arabic Name',
                      hint: 'name',
                      filled: true,
                      fillColor: appGrey.withOpacity(0.2),
                      borderColor: appGrey.withOpacity(0.2),
                      focusBorderColor: appGrey.withOpacity(0.2),
                      autofillHints: const [AutofillHints.addressCityAndState],
                      keyboardType: TextInputType.streetAddress,
                      contentPadding: 10,
                      borderRadius: 8,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return Validation.validate(value!, 'name');
                      },
                      isLabel: true,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    clearcontroller();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    /// add method for update
                    await CategoryGetandPostController.to
                        .updateCategory(
                            categoryId: categoryId!,
                            engName: nameController.text,
                            arName: arabicController.text)
                        .then((value) {
                      if (value) {
                        rebuild();
                        MyFlushBar.showSimpleFlushBar(
                            'Category Updated', context, Colors.green, white);
                      } else {
                        MyFlushBar.showSimpleFlushBar(
                            'Update Failed', context, Colors.redAccent, white);
                      }
                    });
                  },
                  child: CategoryGetandPostController.to.isLoading2 == false
                      ? const Text("Update")
                      : const CircularProgressIndicator(),
                ),
              ],
            );
          },
        );
      },
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
