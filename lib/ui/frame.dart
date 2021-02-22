import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:menetrend/data/context/app.dart';
import 'package:menetrend/helpers/theme.dart';
import 'package:menetrend/ui/page/route/page.dart';

class FramePage extends StatefulWidget {
  final String title;
  FramePage({this.title = "No name"});

  @override
  _FramePageState createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              ThemeHelper(context).setTheme(
                app.settings.themetype == ThemeSetting.light
                    ? ThemeSetting.dark
                    : ThemeSetting.light,
              );
            },
            icon: Icon(
              app.settings.themetype == ThemeSetting.light
                  ? FeatherIcons.moon
                  : FeatherIcons.sun,
            ),
          ),
        ],
      ),
      body: RoutePage(),
    );
  }
}
