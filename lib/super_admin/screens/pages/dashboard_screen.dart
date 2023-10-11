import 'package:admin_panel_so/utils/constants.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/header.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Container(color: Colors.grey),
                      const SizedBox(height: defaultPadding),
                      Container(color: Colors.amberAccent,),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) Container(color: Colors.blue.shade400,)
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Container(color: Colors.green.shade200),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
