import 'package:flutter/material.dart';

class BottomCard extends StatelessWidget {
  final Widget child;

  BottomCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 70.0),
      padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: child,
    );
  }
}
