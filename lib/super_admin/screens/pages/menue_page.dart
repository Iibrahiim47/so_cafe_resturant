// ignore_for_file: avoid_print
import 'dart:io';
import 'package:admin_panel_so/constant/media_qury.dart';
import 'package:admin_panel_so/controller/menu_controller.dart';
import 'package:admin_panel_so/sub_admin/model/get_category_model.dart';
import 'package:admin_panel_so/sub_admin/model/get_product_model.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../../../../constant/app_color.dart';
import '../../../../../utils/responsive.dart';
import '../../../../../utils/static.dart';
import '../../../constant/validator.dart';
import '../../../utils/app_toast.dart';
import '../../../utils/flushbar.dart';
import '../../../utils/shared_widget/appTextField.dart';

class MenuPage extends StatefulWidget {
  final int? categId;
  final String? catgName;

  const MenuPage({super.key, this.categId, this.catgName});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final formKey = GlobalKey<FormState>();
  final menuObj = Get.put(MenuContreoller());
  TextEditingController nameController = TextEditingController();
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController indexController = TextEditingController();

  List<DropdownMenuItem<DataList>> categoryDropdownMenuItems = [];

  clearController() {
    nameController.clear();
    arabicNameController.clear();
    descriptionController.clear();
    indexController.clear();
    priceController.clear();
    categoryDropdownMenuItems.clear();
    MenuContreoller.to.selectedImage = null;
  }

  @override
  void initState() {
    selectedCategory = widget.categId;
    MenuContreoller.to.fetchProductList(categoryId: selectedCategory);
    super.initState();
  }

  rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print("Categ ${widget.categId}");
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.catgName} /Menu'),
      ),
      body: GetBuilder<MenuContreoller>(builder: (obj) {
        return SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              ReorderableGridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 170, mainAxisExtent: 170),
                shrinkWrap: true,
                onReorder: (oldIndex, newIndex) {
                  print(oldIndex);
                  print(
                      "------------------------------------------this is old index");
                  print(newIndex);
                  print(
                      "------------------------------------------this is new index");
                  int oldProductId =
                      obj.getProductListData[oldIndex].productId!;
                  int newCategoryId =
                      obj.getProductListData[newIndex].productId!;
                  obj.updateProductIndex(
                      productId: oldProductId, newIndex: newIndex);
                  obj
                      .updateProductIndex(
                          productId: newCategoryId, newIndex: oldIndex)
                      .then(
                    (value) {
                      obj.fetchProductList(categoryId: selectedCategory);
                    },
                  );
                },
                itemCount: obj.getProductListData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    key: Key(obj.getProductListData[index].engName!),
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: popUp(
                                    modal: obj.getProductListData[index])),
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
                                      useOldImageOnUrlChange: true,
                                      imageUrl:
                                          "${StaticValues.imageUrl}${obj.getProductListData[index].imageUrl!}"),
                                )),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  Text(
                                    obj.getProductListData[index].engName!,
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
                    ),
                  );
                },
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
                    title: const Text("New Product"),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => menuObj.pickGalleryImage().then((_) {
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
                                child: menuObj.selectedImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            10), // Apply the same radius as the Card
                                        child: Image.file(
                                          File(menuObj.selectedImage!.path),
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
                          menuObj.selectedImage == null
                              ? const Text('Tap to pick image')
                              : const SizedBox(),
                          AppTextField(
                            controller: nameController,
                            label: 'Product',
                            hint: 'english name',
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
                              return Validation.validate(value!, 'name');
                            },
                            isLabel: true,
                          ),
                          AppTextField(
                            controller: arabicNameController,
                            label: 'Arabic Name',
                            hint: 'arabic name',
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
                              return Validation.validate(value!, 'name');
                            },
                            isLabel: true,
                          ),
                          AppTextField(
                            controller: priceController,
                            label: 'Price',
                            hint: '00.0',
                            filled: true,
                            fillColor: appGrey.withOpacity(0.2),
                            borderColor: appGrey.withOpacity(0.2),
                            focusBorderColor: appGrey.withOpacity(0.2),
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            contentPadding: 10,
                            borderRadius: 8,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              return Validation.validate(value!, 'price');
                            },
                            isLabel: true,
                          ),
                          AppTextField(
                            controller: descriptionController,
                            label: 'Description',
                            hint: 'product detail',
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
                              return Validation.validate(value!, 'description');
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
                          menuObj.selectedImage = null;
                          menuObj.isLoading2 = false;
                          clearController();
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            menuObj.isLoading2 = true;
                          });

                          menuObj
                              .addNewProduct(
                                  categoryId: widget.categId,
                                  engName: nameController.text,
                                  arbName: arabicNameController.text,
                                  description: descriptionController.text,
                                  price: double.parse(priceController.text))
                              .then((value) {
                            setState(() {
                              rebuild();
                              menuObj.isLoading2 = false;
                              Get.back();
                              clearController();
                              appToast(msg: 'Branch Added', context: context);
                            });
                          });
                        },
                        child: menuObj.isLoading2 == false
                            ? const Text("Save")
                            : const CircularProgressIndicator(),
                      ),
                    ],
                  );
                });
          },
          backgroundColor: primary,
          child: const Icon(Icons.add)),
    );
  }

  popUp({required Data modal}) {
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
                  menuObj
                      .deleteProduct(productId: modal.productId!)
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
          updateProduct(
            productId: modal.productId!,
            price: modal.price!,
            description: modal.description!,
            engName: modal.engName!,
            araName: modal.araName!,
          );
        } else if (value == 2) {
          /// TODO use this method to update
          updateProductIndex(productId: modal.productId!);
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

  void updateProduct(
      {required String engName,
      required String araName,
      required double price,
      required String description,
      required int productId}) {
    setState(() {
      nameController.text = engName.toString();
      arabicNameController.text = araName.toString();
      descriptionController.text = description.toString();
      priceController.text = price.toString();
    });
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog.adaptive(
              scrollable: true,
              title: const Text("Update Category"),
              content: SizedBox(
                width: !Responsive.isMobile(context)
                    ? mediaQueryWidth(context) * 0.3
                    : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => menuObj.pickGalleryImage().then((_) {
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
                          child: menuObj.selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10), // Apply the same radius as the Card
                                  child: Image.file(
                                    File(menuObj.selectedImage!.path),
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
                    menuObj.selectedImage == null
                        ? const Text('Tap to pick image')
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: nameController,
                      label: 'Product',
                      hint: 'english name',
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
                        return Validation.validate(value!, 'name');
                      },
                      isLabel: true,
                    ),
                    AppTextField(
                      controller: arabicNameController,
                      label: 'Arabic Name',
                      hint: 'arabic name',
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
                        return Validation.validate(value!, 'name');
                      },
                      isLabel: true,
                    ),
                    AppTextField(
                      controller: priceController,
                      label: 'Price',
                      hint: '00.0',
                      filled: true,
                      fillColor: appGrey.withOpacity(0.2),
                      borderColor: appGrey.withOpacity(0.2),
                      focusBorderColor: appGrey.withOpacity(0.2),
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      contentPadding: 10,
                      borderRadius: 8,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return Validation.validate(value!, 'price');
                      },
                      isLabel: true,
                    ),
                    AppTextField(
                      controller: descriptionController,
                      label: 'Description',
                      hint: 'product detail',
                      filled: true,
                      fillColor: appGrey.withOpacity(0.2),
                      borderColor: appGrey.withOpacity(0.2),
                      focusBorderColor: appGrey.withOpacity(0.2),
                      autofillHints: const [AutofillHints.nameSuffix],
                      keyboardType: TextInputType.name,
                      contentPadding: 10,
                      borderRadius: 8,
                      maxLine: 4,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return Validation.validate(value!, 'description');
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
                    menuObj.isLoading2 = false;
                    clearController();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    await menuObj
                        .updateProduct(
                            productId: productId,
                            engName: nameController.text,
                            arbName: arabicNameController.text,
                            description: descriptionController.text,
                            price:
                                double.parse(priceController.text.toString()),
                            categoryId: widget.categId!)
                        .then((value) {
                      if (value) {
                        Get.back();
                        rebuild();
                        clearController();
                      } else {
                        Get.back();
                        rebuild();
                        clearController();
                      }
                    });
                  },
                  child: menuObj.isLoading2 == false
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

  void updateProductIndex({required int productId}) {
    Get.defaultDialog(
        title: "Update Index",
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              menuObj.isLoading2 = false;
              clearController();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await menuObj
                  .updateProductIndex(
                      productId: productId,
                      newIndex: int.parse(indexController.text))
                  .then((value) {
                if (value == "updated successfully") {
                  Get.back();
                  rebuild();
                  clearController();
                  MyFlushBar.showSimpleFlushBar(
                      'updated successfully', context, Colors.green, white);
                } else {
                  Get.back();
                  rebuild();
                  clearController();
                  MyFlushBar.showSimpleFlushBar(
                      'Failed', context, Colors.green, white);
                }
              });
            },
            child: menuObj.isLoading2 == false
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
}

Text _text({text, color, required double size}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(color: color, fontSize: size),
  );
}
