import 'package:flutter/material.dart';
import 'package:gtbuddy/utils/colour_pallete.dart';
import 'package:gtbuddy/utils/text_style.dart';


class DashboardResultTile extends StatelessWidget {
  String text;
  Widget page;

  DashboardResultTile(this.text, this.page);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 60,
      decoration: BoxDecoration(
        color: Pallete.BarColor,
      ),
      padding: const EdgeInsets.only(left: 8.0, top: 30.0),
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return page;
                },
                fullscreenDialog: true));
          },
          child: Text("$text",style: AppStyles.Results(),)),
    );
  }
}
