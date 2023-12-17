// ignore_for_file: avoid_print

import 'dart:io';

import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/controller/category_controller.dart';
import 'package:admin_panel_so/sub_admin/model/get_category_model.dart';
import 'package:admin_panel_so/super_admin/screens/pages/menue_page.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant/media_qury.dart';
import '../../../../../controller/menu_controller.dart';
import '../../../constant/validator.dart';
import '../../../utils/app_toast.dart';
import '../../../utils/flushbar.dart';
import '../../../utils/shared_widget/appTextField.dart';

class MainCategoryPage extends StatefulWidget {
  final int? branchId;
  const MainCategoryPage({super.key, this.branchId});

  @override
  State<MainCategoryPage> createState() => _MainCategoryPageState();
}

class _MainCategoryPageState extends State<MainCategoryPage> {
  final categObj = Get.put(CategoryGetandPostController());
  TextEditingController nameController = TextEditingController();
  TextEditingController arabicController = TextEditingController();
  TextEditingController indexController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final menuController = Get.put(MenuContreoller());

  clearcontroller() {
    nameController.clear();
    arabicController.clear();
    indexController.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Category")),
      body: StreamBuilder(
        stream:
            categObj.fetchCatagoriesList(branchId: widget.branchId).asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 170, mainAxisExtent: 170),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => MenuPage(
                          catgName: snapshot.data![index].araName,
                          categId: snapshot.data![index].categoryId,
                        ));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: popUp(modal: snapshot.data![index])),
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: mediaQueryWidth(context),
                              child: CachedNetworkImage(
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  fit: BoxFit.cover,
                                  useOldImageOnUrlChange: true,
                                  imageUrl:
                                      "${StaticValues.imageUrl}${snapshot.data![index].imageUrl!}"),
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data![index].araName!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
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
                );
              },
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(child: CircularProgressIndicator());
          }
          return const Center(
            child: Text('No Category found'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addCategory();
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
                  categObj
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
          /// TODO use this method to update
          updateCategory(
              engName: modal.engName,
              araName: modal.araName,
              categoryId: modal.categoryId,
              imageUrl: modal.imageUrl);
        }else if (value == 2) {
          /// TODO use this method to update
          updateCategoryIndex(categoryId: modal.categoryId!);
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
          const PopupMenuItem(
              value: 2,
              child: Row(
                children: [Icon(Icons.update), Text('update Index')],
              )),
        ];
      },
      child: const Icon(Icons.more_vert, color: appWhite),
    );
  }

  addCategory() {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          print('Dialog Builder rebuild');
          return StatefulBuilder(
            builder: (context, setState) {
              print('StateFul Builder rebuild');

              return AlertDialog.adaptive(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                scrollable: true,
                title: const Text("New Category"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => categObj.pickGalleryImage().then((_) {
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
                            child: categObj.selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Apply the same radius as the Card
                                    child: Image.file(
                                      File(categObj.selectedImage!.path),
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
                      categObj.selectedImage == null
                          ? const Text('Tap to pick image')
                          : const SizedBox(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Customize the border color
                          ),
                          borderRadius: BorderRadius.circular(5), // Customize the border radius
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButton<String>(
                          value: categObj.dropDownValue,
                          onChanged: (value) {
                            categObj.changeCategoryType(value!);
                            setState((){});
                          },
                          items: categObj.typeList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
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
                      categObj.selectedImage = null;
                      categObj.isLoading2 = false;
                      clearcontroller();
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        categObj.isLoading2 = true;
                      });

                      categObj
                          .addNewCategory(
                              branchId: widget.branchId,
                              engName: nameController.text,
                              arbName: arabicController.text)
                          .then((value) {
                        setState(() {
                          rebuild();
                          categObj.isLoading2 = false;
                          Navigator.pop(context);
                          clearcontroller();
                          appToast(msg: 'Branch Added', context: context);
                        });
                      });
                    },
                    child: categObj.isLoading2 == false
                        ? const Text("Save")
                        : const CircularProgressIndicator(),
                  ),
                ],
              );
            },
          );
        });
  }

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
                      onTap: () => categObj.pickGalleryImage().then((_) {
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
                          child: categObj.selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10), // Apply the same radius as the Card
                                  child: Image.file(
                                    File(categObj.selectedImage!.path),
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
                    categObj.selectedImage == null
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
                    categObj.isLoading2 = false;
                    clearcontroller();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    /// add method for update
                    await categObj
                        .updateCategory(
                            categoryId: categoryId!,
                            engName: nameController.text,
                            arName: arabicController.text)
                        .then((value) {
                      if (value) {
                        rebuild();
                        MyFlushBar.showSimpleFlushBar(
                            'Category Updated', context, Colors.green, white);
                        Get.back();
                      } else {
                        MyFlushBar.showSimpleFlushBar(
                            'Update Failed', context, Colors.redAccent, white);
                        Get.back();
                      }
                    });
                  },
                  child: categObj.isLoading2 == false
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
  void updateCategoryIndex({required int categoryId}) {
    Get.defaultDialog(
        title: "Update Index",
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              categObj.isLoading2 = false;
              clearcontroller();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await categObj
                  .updateCategoryIndex(categoryId: categoryId,newIndex: int.parse(indexController.text))
                  .then((value) {
                if (value=="updated successfully") {
                  Get.back();
                  rebuild();
                  clearcontroller();
                  MyFlushBar.showSimpleFlushBar(
                      'updated successfully', context, Colors.green, white);
                } else {
                  Get.back();
                  rebuild();
                  clearcontroller();
                  MyFlushBar.showSimpleFlushBar(
                      'Failed', context, Colors.green, white);
                }
              });
            },
            child: categObj.isLoading2 == false
                ? const Text("Update")
                : const CircularProgressIndicator(),
          ),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: indexController,
              label: 'Index',
              hint: 'new Index',
              filled: true,
              fillColor: appGrey.withOpacity(0.2),
              borderColor: appGrey.withOpacity(0.2),
              focusBorderColor: appGrey.withOpacity(0.2),
              keyboardType: TextInputType.number,
              contentPadding: 10,
              borderRadius: 8,
              maxLine: 1,
              textInputAction: TextInputAction.next,
              validator: (value) {
                return Validation.validate(value!, 'number');
              },
              isLabel: true,
            ),
          ],
        ));
  }

  Text _text({text, color, required double size}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: size),
    );
  }
}
