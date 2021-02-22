import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:menetrend/data/context/app.dart';
import 'package:menetrend/data/controller/settings.dart';

class ThemeHelper {
  BuildContext context;
  ThemeHelper(this.context);

  setTheme(ThemeSetting themeSetting) {
    switch (themeSetting) {
      case ThemeSetting.dark:
        app.settings.theme = Themes.dark;
        app.settings.themetype = ThemeSetting.dark;
        DynamicTheme.of(context).setThemeData(Themes.dark);
        break;
      case ThemeSetting.light:
        app.settings.theme = Themes.light;
        app.settings.themetype = ThemeSetting.light;
        DynamicTheme.of(context).setThemeData(Themes.light);
        break;
    }
  }
}

enum ThemeSetting {
  dark,
  light,
}
