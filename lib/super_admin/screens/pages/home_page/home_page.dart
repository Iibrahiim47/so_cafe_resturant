import 'package:admin_panel_so/controller/category_controller.dart';
import 'package:admin_panel_so/controller/get_branch_controller/get_branch_controller.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/app_color.dart';
import '../../../../../../controller/get_users_profile_ontroller/get_user_profile_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final branchadminobj = Get.put(GetBranchListController());
  final adminobj = Get.put(GetuserProfileController());
  final categobj = Get.put(CategoryGetandPostController());

  @override
  Widget build(BuildContext context) {
    print(StaticData.token);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: const Text("Home"),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _text(
                  text: "Admins",
                  color: appWhite,
                  size: 16.0,
                ),
              ),
            ),
            /// Admins List
            StreamBuilder(
              stream: adminobj.fetchUserProfileMethod().asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 170,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: onPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(CupertinoIcons.person_crop_circle,color: appBlack ,size: 32),
                            _text(
                              text: snapshot.data![index].name!,
                              color: appBlack,
                              size: 16.0,
                            ),
                            _text(
                              text: snapshot.data![index].email!,
                              color: appBlack,
                              size: 14.0,
                            ),
                            _text(
                              text: snapshot.data![index].branchName!,
                              color: appBlack,
                              size: 16.0,
                            ),
                          ],
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
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(
                  child: Text('No data'),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _text(
                  text: "Branches",
                  color: appWhite,
                  size: 16.0,
                ),
              ),
            ),

            /// branches list
            StreamBuilder(
              stream: branchadminobj.fetchBranchesList().asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: primary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.fastfood,color: appBlack),
                            _text(
                              text: snapshot.data![index].name!,
                              color: appBlack,
                              size: 16.0,
                            ),
                            _text(
                              text: snapshot.data![index].address!,
                              color: appBlack,
                              size: 14.0,
                            ),
                          ],
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 170,
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(
                  child: Text('No data'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget admins() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Admins',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
      ],
    );
  }

  Widget branches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Branches',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: branchadminobj.fetchBranchesList().asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _text(
                          text: snapshot.data![index].name!,
                          color: appBlack,
                          size: 16.0,
                        ),
                        _text(
                          text: snapshot.data![index].address!,
                          color: appBlack,
                          size: 14.0,
                        ),
                      ],
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 170,
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return const Center(
                child: Text('No data'),
              );
            },
          ),
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
