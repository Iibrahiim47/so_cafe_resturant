import 'package:admin_panel_so/controller/add_branch_controller/add_branch_controller.dart';
import 'package:admin_panel_so/controller/get_branch_controller/get_branch_controller.dart';
import 'package:admin_panel_so/models/get_branches.dart';
import 'package:admin_panel_so/utils/flushbar.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/models/add_branch_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant/app_color.dart';
import '../../../../../constant/media_qury.dart';
import '../../../constant/validator.dart';
import '../../../utils/app_toast.dart';
import '../../../utils/shared_widget/appTextField.dart';
import 'main_category.dart';

class BranchPage extends StatefulWidget {
  const BranchPage({super.key});

  @override
  State<BranchPage> createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage> {
  final getBranchObj = Get.put(GetBranchListController());
  final addBranchObj = Get.put(AddBranchController());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameControler = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addedByController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isimageselected = false;

  clearController() {
    nameControler.clear();
    addressController.clear();
  }

  rebuild() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = mediaQueryHeight(context);
    var width = mediaQueryWidth(context);
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        height: height,
        alignment: Alignment.center,
        width: width,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: const Text("Branches"),
              ),
              const Divider(),
              Expanded(
                child: StreamBuilder(
                    stream: getBranchObj.fetchBranchesList().asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: Responsive.isDesktop(context)
                                      ? mediaQueryWidth(context) * 0.12
                                      : mediaQueryHeight(context) * 0.2,
                                  crossAxisCount:
                                      Responsive.isMobile(context) ? 2 : 4),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => MainCategoryPage(
                                    branchId: snapshot.data![index].branchId));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  image: DecorationImage(
                                    image: AssetImage('images/homebg.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: popUp(
                                            modal: snapshot.data![index])),
                                    _text(
                                        text: snapshot.data![index].name!,
                                        color: appBlack,
                                        size: 16.0),
                                    _text(
                                        text: snapshot.data![index].address!,
                                        color: appBlack,
                                        size: 14.0),
                                    _text(
                                        text: snapshot
                                            .data![index].registrationDateTime,
                                        color: appBlack,
                                        size: 16.0),
                                    _text(
                                        text: "See Menu >>",
                                        size: 14,
                                        color: appWhite)
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        const Center(child: CircularProgressIndicator());
                      }
                      return const Center(
                        child: Text('No data'),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addBranchDialog();
          },
          backgroundColor: primary,
          child: const Icon(Icons.add)),
    );
  }

  Widget popUp({required Data modal}) {
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
                  addBranchObj.deleteBranch(modal.branchId!).then((value) {
                    setState(() {
                      rebuild();
                      Get.back();
                      appToast(msg: 'Branch deleted', context: context);
                    });
                  });
                },
                child: const Text('Yes')),
          );
        } else if (value == 1) {
          /// TODO use this method to update
          updateBranch(modal: modal);
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
    );
  }

  void addBranchDialog() {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog.adaptive(
              scrollable: true,
              alignment: Alignment.centerRight,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: const Text("Add New Branch"),
              content: Column(
                children: [
                  AppTextField(
                    controller: nameControler,
                    label: 'Branch Name',
                    hint: 'branch name',
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
                    controller: addressController,
                    label: 'Address',
                    hint: 'branch address',
                    filled: true,
                    fillColor: appGrey.withOpacity(0.2),
                    borderColor: appGrey.withOpacity(0.2),
                    focusBorderColor: appGrey.withOpacity(0.2),
                    autofillHints: const [AutofillHints.addressCity],
                    keyboardType: TextInputType.streetAddress,
                    contentPadding: 10,
                    borderRadius: 8,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return Validation.validate(value!, 'address');
                    },
                    isLabel: true,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      addBranchObj.isLoading2 = true;
                    });

                    AddBranchModel addAdminModal = AddBranchModel(
                        name: nameControler.text,
                        address: addressController.text);

                    addBranchObj.addBranchMethod(addAdminModal).then((value) {
                      setState(() {
                        rebuild();
                        addBranchObj.isLoading2 = false;
                        Navigator.pop(context);
                        clearController();
                        appToast(msg: 'Branch Added', context: context);
                      });
                    });
                  },
                  child: addBranchObj.isLoading2 == false
                      ? const Text("Save")
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

  void updateBranch({required Data modal}) {
    setState(() {
      nameControler.text = modal.name.toString();
      addressController.text = modal.address.toString();
    });
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog.adaptive(
              title: const Text("Update SubAdmin"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    controller: nameControler,
                    label: 'Branch Name',
                    hint: 'branch name',
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
                    controller: addressController,
                    label: 'Address',
                    hint: 'address',
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
                      return Validation.validate(value!, 'address');
                    },
                    isLabel: true,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    clearController();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  /// method for update
                  onPressed: () async {
                    await addBranchObj
                        .updateBranch(
                            branchId: modal.branchId!,
                            address: addressController.text,
                            name: nameControler.text)
                        .then((value) {
                      if (value) {
                        rebuild();
                        MyFlushBar.showSimpleFlushBar(
                            'Branch Updated', context, Colors.green, white);
                      } else {
                        MyFlushBar.showSimpleFlushBar('Update Failed',
                            context, Colors.redAccent, white);
                      }
                    });


                  },
                  child: addBranchObj.isLoading2 == false
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
}
