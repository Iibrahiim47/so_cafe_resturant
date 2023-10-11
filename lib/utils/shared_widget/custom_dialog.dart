import 'package:admin_panel_so/constant/media_qury.dart';
import 'package:admin_panel_so/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomDialog extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final String date;

  const CustomDialog({super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: Responsive.isDesktop(context)? mediaQueryWidth(context)*0.2 : mediaQueryWidth(context)*0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: Responsive.isDesktop(context)? mediaQueryWidth(context)*200 : mediaQueryWidth(context)*0.5,
              height:200,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16.0),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Price: \$${price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}