import 'package:flutter/material.dart';
import 'package:menetrend/ui/frame.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = "Menetrendek";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menetrendek',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FramePage(title: title),
    );
  }
}
