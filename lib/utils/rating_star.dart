import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final double rating;

  const RatingStar({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        IconData iconData;
        Color starColor;

        if (rating >= index + 1) {
          iconData = Icons.star; // Filled star
          starColor = Colors.orange; // Filled star color
        } else if (rating > index && rating < index + 1) {
          iconData = Icons.star_half; // Half-filled star
          starColor = Colors.orange; // Half-filled star color
        } else {
          iconData = Icons.star_border; // Outline (empty) star
          starColor = Colors.grey; // Empty star color
        }

        return Icon(
          iconData,
          color: starColor,
        );
      }),
    );
  }
}
