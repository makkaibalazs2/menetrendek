import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class InfoChip extends StatelessWidget {
  final icondata;
  final text;
  final color;
  final border;
  InfoChip(
      {this.icondata = FeatherIcons.info,
      this.text = "",
      this.color = Colors.black,
      this.border = true});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: border
            ? ShapeDecoration(
                shape: StadiumBorder(
                  side: BorderSide(
                    width: 1,
                    color: color,
                    style: BorderStyle.solid,
                  ),
                ),
              )
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icondata,
              color: color,
            ),
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                color: color,
              ),
            ),
          ],
        ));
  }
}
