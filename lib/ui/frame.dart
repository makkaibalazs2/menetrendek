import 'package:flutter/material.dart';
import 'package:menetrend/ui/page/route/page.dart';

class FramePage extends StatefulWidget {
  final String title;
  FramePage({this.title = "No name"});

  @override
  _FramePageState createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RoutePage(),
    );
  }
}
