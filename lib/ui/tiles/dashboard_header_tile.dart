import 'package:gtbuddy/utils/colour_pallete.dart';
import 'package:gtbuddy/utils/text_style.dart';
import 'package:flutter/material.dart';

class DashboardTile extends StatelessWidget {
  final String text;
  final double height;

  DashboardTile(this.text, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: 400,
      height: height,
      color: Pallete.BarHeadColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 5),
        child: Text('$text', style: AppStyles.Header()),
      ),
    );
  }
}
