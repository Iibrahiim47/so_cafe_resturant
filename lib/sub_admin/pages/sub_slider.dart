// import 'package:admin_panel_so/constant/app_color.dart';
// import 'package:admin_panel_so/controller/menu_controller.dart';
// import 'package:admin_panel_so/sub_admin/model/get_slider_model.dart';
// import 'package:admin_panel_so/utils/static.dart';
// import 'package:admin_panel_so/utils/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SliderPage extends StatefulWidget {
//   const SliderPage({super.key});
//
//   @override
//   State<SliderPage> createState() => _SliderPageState();
// }
//
// class _SliderPageState extends State<SliderPage> {
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       body: GetBuilder<MenuContreoller>(builder: (obj) {
//         return SizedBox(
//             height: height,
//             width: width,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 SizedBox(
//                   height: height * 0.15,
//                   width: width,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: width * 0.01,
//                       right: width * 0.01,
//                     ),
//                     child: Row(
//                       children: [
//                         obj.sliderImage == null
//                             ? InkWell(
//                                 onTap: () {
//                                   obj.addSliderImage(context);
//                                 },
//                                 child: Container(
//                                   height: height,
//                                   width: width * 0.1,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(),
//                                   ),
//                                   child: const Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Icon(Icons.image),
//                                       Text("Select Image")
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             : Container(
//                                 height: height,
//                                 width: width * 0.1,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     image: DecorationImage(
//                                       fit: BoxFit.cover,
//                                       image: NetworkImage(
//                                         obj.sliderImage!.path,
//                                       ),
//                                     ),
//                                     border: Border.all()),
//                               ),
//                         SizedBox(
//                           width: width * 0.02,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(30.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               obj.addSliderItem();
//                               // print(nameController.text);
//                               // print(arabicController.text);
//                               // print(obj.image);
//                               // if (formKey.currentState!.validate()) {
//                               //   CategoryGetandPostController.to
//                               //       .uploadFooterItem(
//                               //     nameController.text,
//                               //     arabicController.text,
//                               //   );
//
//                               //   // clearcontroller();
//                               //   MyFlushBar.showSimpleFlushBar(
//                               //       "Added successfully",
//                               //       context,
//                               //       Colors.green,
//                               //       Colors.white);
//                               // } else {
//                               //   MyFlushBar.showSimpleFlushBar(
//                               //       "Fill All the fields",
//                               //       context,
//                               //       AdminTheme.errorColor,
//                               //       AdminTheme.secondryColor);
//                               // }
//                             },
//                             child: Container(
//                               height: height,
//                               width: width * 0.2,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: primary,
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Text(
//                                 "ADD Slide",
//                                 style: TextStyle(
//                                   color: appSecondary,
//                                   fontSize: width * 0.015,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 const Divider(),
//                 FutureBuilder<List<Data>>(
//                     future: obj.getSliderList(),
//                     builder: (context, snapshot) {
//                       return Expanded(
//                         child: SizedBox(
//                           height: height,
//                           width: width,
//                           // color: Colors.amber,
//                           child: GridView.builder(
//                             itemCount: obj.getSliderListData.length,
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 4,
//                             ),
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   // obj.deleteSliderMethiod(
//                                   //     obj.getSliderListData[index].sliderId!);
//                                   print("sliderID is${obj.sliderId}");
//                                 },
//                                 child: Card(
//                                   elevation: 10,
//                                   shadowColor: primary,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Container(
//                                     height: height * 0.2,
//                                     width: width,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       image: DecorationImage(
//                                         fit: BoxFit.cover,
//                                         image: NetworkImage(
//                                           "${StaticValues.imageUrl}${snapshot.data![index].imageUrl!}",
//                                         ),
//                                       ),
//                                       border: Border.all(),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       );
//                     })
//               ],
//             ));
//       }),
//     );
//   }
// }
