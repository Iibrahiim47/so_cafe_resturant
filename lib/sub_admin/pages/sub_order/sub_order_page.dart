import 'package:admin_panel_so/constant/media_qury.dart';
import 'package:admin_panel_so/models/sub_order_model.dart';
import 'package:admin_panel_so/sub_admin/pages/sub_order/sub_order_controller.dart';
import 'package:admin_panel_so/sub_admin/pages/sub_order/sub_order_data.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/app_color.dart';
import '../../../utils/shared_widget/appTextStyle.dart';

class SubOrderPage extends StatefulWidget {
  const SubOrderPage({super.key});

  @override
  State<SubOrderPage> createState() => _SubOrderPageState();
}

class _SubOrderPageState extends State<SubOrderPage> {
  @override
  Widget build(BuildContext context) {
    // final obj = Get.put(SubOrderController);

    return GetBuilder(
      init: Get.put(SubOrderController()),
      builder: (obj) {
        return Column(
          children: [
            StreamBuilder<List<Data>>(
              stream: obj
                  .fetchOrderAdmin(StaticData.userProfile!.data!.branchId)
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No data available');
                } else {
                  return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var orderdata = snapshot.data![index];
                          return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(SubOrderData(
                                    data: snapshot.data![index],
                                  ));
                                },
                                child: SizedBox(
                                  height: 80,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: ListTile(
                                      isThreeLine: true,
                                     leading: CircleAvatar(
                                        child: AppTextStyle(text:StaticData.userProfile!.data!.name![0].toUpperCase() +
                                            StaticData.userProfile!.data!.name![1],fontSize: 20,textColor: appWhite),

                                        backgroundColor: primary,
                                      ),
                                      title: Text(orderdata.name.toString()),
                                      subtitle: Text(
                                        orderdata.email.toString(),
                                        style: TextStyle(color: primary),
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      // l: Text(orderdata.status.toString()),
                                    ),
                                  ),
                                ),
                              ));
                        },
                      ));
                }
              },
            )
          ],
        );
      },
    );
  }
}
