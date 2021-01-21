import "package:flutter/material.dart";
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:menetrend/model/travel_route.dart';
import 'package:menetrend/ui/infochip.dart';

class InfoTile extends StatelessWidget {
  final TravelRoute route;
  InfoTile(this.route);

  Widget build(BuildContext context) {
    print(route.transferCount.toString());
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(route.from),
                    Text(route.departure),
                  ],
                ),
              ),
              Text(
                "-",
                style: TextStyle(fontSize: 30),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(route.to),
                    Text(route.arrival),
                  ],
                ),
              ),
            ],
          ),
          route.transferCount > 0
              ? InfoChip(text: "Átszállással", border: false)
              : Container(),
        ],
      ),
    );
  }
}
