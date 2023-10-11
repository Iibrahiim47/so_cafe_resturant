import 'package:admin_panel_so/constant/media_qury.dart';
import 'package:admin_panel_so/controller/branch_controller.dart';
import 'package:admin_panel_so/controller/get_branch_controller/get_branch_controller.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
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
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text("Home"),
          ),

          Expanded(
            child: Row(children: [
              Expanded(child: admins()),
              Expanded(child: branches())
            ],),
          )
        ],
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
        Expanded(
            child: StreamBuilder(
          stream: adminobj.fetchUserProfileMethod().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: Responsive.isDesktop(context)
                          ? mediaQueryWidth(context) * 0.1
                          : mediaQueryHeight(context) * 0.1,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: appGrey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                    ),
                  );





                }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:  Responsive.isMobile(context)? 1:2),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(
              child: Text('No data'),
            );
          },
        ))
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
                stream: branchadminobj.fetchBranchesList().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                     // scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width:
                          200, // Set the width of the container as needed
                          decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                              color: appGrey),
                          child: Column(
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
                          ),
                        );




                      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:Responsive.isMobile(context)? 1:2,crossAxisSpacing: 10,mainAxisSpacing: 10),
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
          ),
        )
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
