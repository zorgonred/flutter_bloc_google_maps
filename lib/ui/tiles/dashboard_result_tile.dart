import 'package:gtbuddy/utils/colour_pallete.dart';
import 'package:gtbuddy/utils/text_style.dart';
import 'package:flutter/material.dart';

class DashboardResultTile extends StatelessWidget {
  final String text;
  final Widget link;
  final Widget linkk;

  DashboardResultTile(this.text, this.link, this.linkk);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      color: Pallete.BarColor,
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: () {
          link;
          linkk;
        },
        child: Text("$text", style: AppStyles.Results()),
      ),
    );
  }
}
