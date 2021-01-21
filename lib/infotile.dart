import "package:flutter/material.dart";

class InfoTile extends StatelessWidget {
  final route;
  InfoTile(this.route);

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        // Egész sor
        children: <Widget>[
          Expanded(
            child: Column(
              // Elindulás oszlop
              children: <Widget>[
                Text(route.from),
                Text(route.departure),
              ],
            ),
          ),
          Expanded(
            child: Column(
              //Megérkezés oszlop
              children: <Widget>[
                Text(route.to),
                Text(route.arrival),
              ],
            ),
          ),
          Text(route.transferCount.toString()), // átszállás db szám
          Expanded(
            child: SingleChildScrollView(
              // átszállások, ami scrollolható lefele
              physics: BouncingScrollPhysics(),
              child: Text(
                route.transfers
                    .join("\n"), //Listát egy stringbe rakod, ami több soros
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// megnyomtam
// masik fileba, main.dart
