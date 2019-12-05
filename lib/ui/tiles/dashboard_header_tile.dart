import 'package:flutter/material.dart';
import 'package:gtbuddy/utils/colour_pallete.dart';
import 'package:gtbuddy/utils/text_style.dart';

class DashboardTile extends StatelessWidget {
  String text;
  double height;

  DashboardTile(this.text, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: height,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
        color: Pallete.BarHeadColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 30.0),
        child: Text(
          '$text',
          style: AppStyles.Header(),
        ),
      ),
    );
  }
}
