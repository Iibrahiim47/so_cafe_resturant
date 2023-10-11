// ignore_for_file: avoid_print

import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/constant/media_qury.dart';
import 'package:admin_panel_so/controller/add_admin_controller/add_admin_controller.dart';
import 'package:admin_panel_so/controller/get_users_profile_ontroller/get_user_profile_controller.dart';
import 'package:admin_panel_so/models/signup_model.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/models/get_branches.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../constant/validator.dart';
import '../../../models/get_users_model.dart' as getUserModal;
import '../../../utils/app_toast.dart';
import '../../../utils/shared_widget/appTextField.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final obj = Get.put(GetuserProfileController());
  final addAdminObj = Get.put(AddAdminController());

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String initialCountry = 'AE';
  PhoneNumber number = PhoneNumber(isoCode: 'AE');
  List<DropdownMenuItem<Data>> branchdropdownMenuItems = [];
  String fullNumber = "xxxxxxxx";
  final formKey = GlobalKey<FormState>();

  clearcontroller() {
    fullNameController.clear();
    emailController.clear();
    numberController.clear();
    passwordController.clear();
  }

  @override
  void initState() {
    addAdminObj.fetchDropDownBranchList();
    // branchdropdownMenuItems = AddadminController.to
    //     .buildBranchDropdownMenuItems(GetBranchListController.to.allBranchList);
    print(branchdropdownMenuItems.length);
    super.initState();
  }

  rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Form(
            key: formKey,
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: const Text("Admins"),
                ),
                const Divider(),
                SizedBox(
                  height: mediaQueryHeight(context) * 0.1,
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: obj.fetchUserProfileMethod().asStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 20,
                                    mainAxisExtent:
                                        Responsive.isDesktop(context)
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
                                  Get.defaultDialog(
                                      title: "SubAdmin Detail",
                                      content: SizedBox(
                                        height: mediaQueryHeight(context) * 0.4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            _text(
                                                text:
                                                    "Name: ${snapshot.data![index].name!}",
                                                color: appWhite,
                                                size: 16.0),
                                            _text(
                                                text:
                                                    "Email: ${snapshot.data![index].email!}",
                                                color: appWhite,
                                                size: 14.0),
                                            _text(
                                                text:
                                                    "Phone: ${snapshot.data![index].phoneNumber!}",
                                                color: appWhite,
                                                size: 16.0),
                                            _text(
                                                text:
                                                    "Date: ${snapshot.data![index].registrationDateTime!}",
                                                color: appWhite,
                                                size: 16.0),
                                            _text(
                                                text:
                                                    "Branch Date: ${snapshot.data![index].branchDate!}",
                                                color: appWhite,
                                                size: 16.0),
                                            _text(
                                                text:
                                                    "Branch: ${snapshot.data![index].branchName!}",
                                                color: appWhite,
                                                size: 16.0),
                                          ],
                                        ),
                                      ),
                                      cancel: TextButton(
                                          onPressed: () => Get.back(),
                                          child: const Text('close')));
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
                                          text: snapshot.data![index].email!,
                                          color: appBlack,
                                          size: 14.0),
                                      _text(
                                          text:
                                              snapshot.data![index].branchName!,
                                          color: appBlack,
                                          size: 16.0),
                                      _text(
                                          text: 'See Detail >>',
                                          color: appWhite,
                                          size: 16.0),
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
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          const Center(child: CircularProgressIndicator());
                        }
                        return const Center(
                          child: Text('No data'),
                        );
                      }),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addAdminDialog();
          },
          backgroundColor: primary,
          child: const Icon(
            Icons.add,
            color: appWhite,
          )),
    );
  }

  void addAdminDialog() {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        print('Dialog Builder rebuild');
        return StatefulBuilder(
          builder: (context, setState) {
            print('StateFul Builder rebuild');
            return AlertDialog.adaptive(
              scrollable: true,
              alignment: Alignment.centerRight,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: const Text("Add New Admin"),
              content: popUpContent(),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    clearcontroller();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      addAdminObj.isLoading2 = true;
                    });

                    SignupResponseModel addAdminModal = SignupResponseModel(
                        name: fullNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phoneNumber: numberController.text,
                        branchId: addAdminObj.selectedBranch!.branchId);

                    addAdminObj.addAdminMethod(addAdminModal).then((value) {
                      setState(() {
                        rebuild();
                        addAdminObj.isLoading2 = false;
                        Navigator.pop(context);
                        appToast(msg: 'Admin Added', context: context);
                        clearcontroller();
                      });
                    });
                  },
                  child: addAdminObj.isLoading2 == false
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

  Widget popUp({required getUserModal.Data modal}) {
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
                  addAdminObj.deleteSubAdmin(modal.userId!).then((value) {
                    setState(() {
                      rebuild();
                      appToast(msg: 'Admin deleted', context: context);
                    });
                  });
                },
                child: const Text('Yes')),
          );

        } else if (value == 1) {
          updateSubAdmin(
              userId: modal.userId,
              email: modal.email,
              name: modal.name,
              number: modal.phoneNumber);
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

  void updateSubAdmin({branch, email, name, number, userId}) {
    setState(() {
      emailController.text = email.toString();
      fullNameController.text = name.toString();
      numberController.text = number.toString();

      print('update email${emailController.text}');
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
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: appGrey),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: DropdownButton<Data>(
                          hint: const Text('Select Branch'),
                          value: addAdminObj.selectedBranch,
                          icon: const Icon(Icons.arrow_drop_down),
                          underline: const SizedBox(),
                          style: const TextStyle(
                            color: appWhite,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          items: buildBranchDropdownMenuItems(
                              addAdminObj.branchList),
                          isExpanded: true,
                          onChanged: (Data? mySelectedBranch) {
                            setState(() {
                              addAdminObj.selectedBranch = mySelectedBranch;
                            });
                          },
                        )),
                      ],
                    ),
                  ),
                  AppTextField(
                    controller: fullNameController,
                    label: 'Admin Name',
                    hint: 'full name',
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
                    controller: emailController,
                    label: 'Email',
                    hint: 'example@gmail.com',
                    filled: true,
                    fillColor: appGrey.withOpacity(0.2),
                    borderColor: appGrey.withOpacity(0.2),
                    focusBorderColor: appGrey.withOpacity(0.2),
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    contentPadding: 10,
                    borderRadius: 8,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return Validation.validate(value!, 'email');
                    },
                    isLabel: true,
                  ),
                  AppTextField(
                    controller: numberController,
                    label: 'Number',
                    hint: '+00 00000000',
                    filled: true,
                    fillColor: appGrey.withOpacity(0.2),
                    borderColor: appGrey.withOpacity(0.2),
                    focusBorderColor: appGrey.withOpacity(0.2),
                    autofillHints: const [AutofillHints.telephoneNumber],
                    keyboardType: TextInputType.phone,
                    contentPadding: 10,
                    borderRadius: 8,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return Validation.validate(value!, 'number');
                    },
                    isLabel: true,
                  ),
                ],
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
                  onPressed: () {
                    /// add method for update
                  },
                  child: addAdminObj.isLoading2 == false
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

  List<DropdownMenuItem<Data>> buildBranchDropdownMenuItems(
      List<Data> branchList) {
    List<DropdownMenuItem<Data>> items = [];
    for (Data branch in branchList) {
      items.add(
        DropdownMenuItem(
          value: branch,
          child: Text(branch.name!),
        ),
      );
    }
    return items;
  }

  popUpContent() {
    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: appGrey),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: DropdownButton<Data>(
                hint: const Text('Select Branch'),
                value: addAdminObj.selectedBranch,
                icon: const Icon(Icons.arrow_drop_down),
                underline: const SizedBox(),
                style: const TextStyle(
                  color: appWhite,
                ),
                borderRadius: BorderRadius.circular(10),
                items: buildBranchDropdownMenuItems(addAdminObj.branchList),
                isExpanded: true,
                onChanged: (Data? mySelectedBranch) {
                  setState(() {
                    addAdminObj.selectedBranch = mySelectedBranch;
                  });
                },
              )),
            ],
          ),
        ),
        AppTextField(
          controller: fullNameController,
          label: 'Admin Name',
          hint: 'full name',
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
          controller: emailController,
          label: 'Email',
          hint: 'example@gmail.com',
          filled: true,
          fillColor: appGrey.withOpacity(0.2),
          borderColor: appGrey.withOpacity(0.2),
          focusBorderColor: appGrey.withOpacity(0.2),
          autofillHints: const [AutofillHints.username],
          keyboardType: TextInputType.emailAddress,
          contentPadding: 10,
          borderRadius: 8,
          textInputAction: TextInputAction.next,
          validator: (value) {
            return Validation.validate(value!, 'email');
          },
          isLabel: true,
        ),
        AppTextField(
          controller: numberController,
          label: 'Number',
          hint: '+00 00000000',
          filled: true,
          fillColor: appGrey.withOpacity(0.2),
          borderColor: appGrey.withOpacity(0.2),
          focusBorderColor: appGrey.withOpacity(0.2),
          autofillHints: const [AutofillHints.telephoneNumber],
          keyboardType: TextInputType.phone,
          contentPadding: 10,
          borderRadius: 8,
          textInputAction: TextInputAction.next,
          validator: (value) {
            return Validation.validate(value!, 'number');
          },
          isLabel: true,
        ),
        AppTextField(
          controller: passwordController,
          label: 'Password',
          hint: 'password',
          psdObs: addAdminObj.psdObs.value,
          borderColor: appGrey.withOpacity(0.2),
          focusBorderColor: primary,
          autofillHints: const [AutofillHints.password],
          keyboardType: TextInputType.visiblePassword,
          contentPadding: 10,
          filled: true,
          fillColor: appGrey.withOpacity(0.2),
          borderRadius: 8,
          obscuringCharacter: '*',
          suffix: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () => setState(() {
                    addAdminObj.psdObs.value = !addAdminObj.psdObs.value;
                  }),
              child: addAdminObj.psdObs.value
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off)),
          textInputAction: TextInputAction.done,
          validator: (value) => Validation.psdValidation(value!),
          isLabel: true,
        ),
      ],
    );
  }
}

Text _text({text, color, required double size}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(color: color, fontSize: size),
  );
}
