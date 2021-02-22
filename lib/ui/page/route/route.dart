import 'package:flutter/material.dart';
import 'package:menetrend/data/model/travel_route.dart';

class RouteView extends StatelessWidget {
  final TravelRoute route;
  RouteView(this.route);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            infoText("Kezdőállomás", route.from),
            infoText("Célállomás", route.to),
            infoText("Indulás ideje", route.departure),
            infoText("Érkezés ideje", route.arrival),
            route.transferCount > 0
                ? infoText("Átszállások száma", route.transferCount.toString())
                : TextSpan(),
            route.transferCount > 0
                ? infoText("Átszállások", route.transfers.join(", "))
                : TextSpan(),
          ],
        ),
      ),
    );
    // time to check filc forráskód
  }
}

TextSpan infoText(String name, String info) {
  return TextSpan(
    children: <TextSpan>[
      TextSpan(
        text: name + ": ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: info + "\n"),
    ],
  );
}
