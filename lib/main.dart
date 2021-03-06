import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'src/homepage.dart';
import 'src/theme/app_theme.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme().lightThemeData,
      darkTheme: AppTheme().darkThemeData,
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
