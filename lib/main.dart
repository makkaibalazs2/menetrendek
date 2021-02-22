import 'package:flutter/material.dart';
import 'package:menetrend/data/context/app.dart';
import 'package:menetrend/data/controller/settings.dart';
import 'package:menetrend/ui/frame.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = "Menetrendek";
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (b) => app.settings.theme,
      themedWidgetBuilder: (context, theme) => MaterialApp(
        title: 'Menetrendek',
        darkTheme: theme == Themes.dark ? Themes.light : Themes.dark,
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: FramePage(title: title),
      ),
    );
  }
}
