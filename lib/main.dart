import 'package:covivre/components/stories/WashHands.dart';
import 'package:covivre/screens/CovidUpdates.dart';
import 'package:covivre/screens/HomePage.dart';
import 'package:covivre/screens/StaySafe.dart';
import 'package:covivre/screens/I.dart';
import 'package:covivre/screens/Fight.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('fr', 'FR'),
          Locale('ru', 'RU')
        ],
        path: 'lang/lang.yaml', // <-- change patch to your
        fallbackLocale: Locale('en', 'US'),
        assetLoader: YamlSingleAssetLoader(),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      title: 'Covivre',
      theme: ThemeData(backgroundColor: Color.fromRGBO(30, 27, 48, 1.0)),
      initialRoute: 'HomePage',
      routes: {
        'HomePage': (context) => HomePage(),
        'StaySafe': (context) => Scaffold(body: StaySafe()),
        'I': (context) => Scaffold(body: I()),
        'Fight': (context) => Fight(),
        'CovidUpdates': (context) => Scaffold(body: CovidUpdates()),
        'WashHands': (context) => Scaffold(body: WashHands())
      },
      home: HomePage(),
    );
  }
}
