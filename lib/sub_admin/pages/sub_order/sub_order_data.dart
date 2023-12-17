import 'package:admin_panel_so/sub_admin/pages/sub_order/sub_order_controller.dart';
import 'package:admin_panel_so/utils/static.dart';
import 'package:admin_panel_so/utils/static_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/media_qury.dart';
import '../../../models/sub_order_model.dart';

class SubOrderData extends StatefulWidget {

   SubOrderData({super.key,  this.data});
    Data? data;

  @override
  State<SubOrderData> createState() => _SubOrderDataState();
}

class _SubOrderDataState extends State<SubOrderData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder(
        init: SubOrderController(),
        builder:(controller) {
        return Column(
          children: [
            SizedBox(
              height: mediaQueryHeight(context)*0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mediaQueryHeight(context)*0.01,
                  ),
                  Row(
                    children: [

                      SizedBox(width: mediaQueryWidth(context) * 0.03),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name :  ${widget.data!.name.toString()}',style: TextStyle(fontSize: 18),),
                          Text('note   :  ${widget.data!.note.toString()}',style: TextStyle(fontSize: 18)),
                          Text('Phone :  ${widget.data!.phoneNumber.toString()}',style: TextStyle(fontSize: 18)),
                          Text('Date   :  ${widget.data!.dateTime.toString()}',style: TextStyle(fontSize: 18)),

                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: mediaQueryHeight(context) * 0.03),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Orders',style:
                      TextStyle(color: Colors.white,fontSize: 18)),
                      Container(
                        height: mediaQueryHeight(context)*0.6,
                        child: Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            itemCount: widget.data!.products!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 7.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  elevation: 5,
                                  child: Column(

                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(

                                          children: [
                                            Container(
                                              width: 50.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: CachedNetworkImageProvider("${StaticValues.imageUrl}${widget.data!.products![index].imageUrl.toString()}"),
                                                ),
                                              ),
                                            ),
                                            // CircleAvatar(
                                            //   backgroundImage: CachedNetworkImageProvider(
                                            //   ),
                                            // ),
                                            SizedBox(width: mediaQueryWidth(context) * 0.03),
                                           Container(
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [

                                                 Text(widget.data!.products![index].engName.toString()),
                                                 Text(widget.data!.products![index].araName.toString()),
                                                 Text('Price : ${widget.data!.products![index].price.toString()}'),


                                               ],
                                             ),
                                           ),
                                            SizedBox(width: mediaQueryWidth(context) * 0.05),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Quantity :${widget.data!.products![index].quantity.toString()}'),
                                                Text('Id :${widget.data!.products![index].productId.toString()}'),

                                              ],
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },),
    );
  }
}
