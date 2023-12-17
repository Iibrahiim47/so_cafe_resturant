// ignore_for_file: avoid_print
import 'dart:io';
import 'package:admin_panel_so/constant/media_qury.dart';
import 'package:admin_panel_so/controller/menu_controller.dart';
import 'package:admin_panel_so/sub_admin/model/get_category_model.dart';
import 'package:admin_panel_so/sub_admin/model/get_product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    super.initState();
  }

  rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    print("Categ ${widget.categId}");
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.catgName} /Menu'),
      ),
      body: StreamBuilder(
        stream: menuObj.fetchProductList(categoryId: widget.categId).asStream(),
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
                  onTap: () {},
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
            child: Text('No Menu found'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addProduct();
          },
          backgroundColor: primary,
          child: const Icon(Icons.add)),
    );
  }

  addProduct() {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog.adaptive(
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
            },
          );
        });
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
