import 'package:gtbuddy/utils/colour_pallete.dart';
import 'package:gtbuddy/utils/text_style.dart';
import 'package:flutter/material.dart';

class DashboardResultTile extends StatelessWidget {
  final String text;
  final Widget page;

  DashboardResultTile(this.text, this.page);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      color: Pallete.BarColor,
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            new MaterialPageRoute<Null>(builder: (BuildContext context) => page, fullscreenDialog: true),
          );
        },
        child: Text("$text", style: AppStyles.Results()),
      ),
    );
  }
}
