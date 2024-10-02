import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:layout/layout.dart';
import 'package:lexicon/constants/constants.dart';
import 'package:lexicon/settings/settings.dart';
import 'package:lexicon/ui/gui/lexicon.dart';
import 'package:provider/provider.dart';

class ApplicationTheme {
  static final ThemeData light = ThemeData.light(useMaterial3: true);
  static final ThemeData dark = ThemeData.dark(useMaterial3: true);

  static ThemeData get current {
    var schedulerBinding = SchedulerBinding.instance;
    var brightness = schedulerBinding.platformDispatcher.platformBrightness;

    if (brightness == Brightness.dark) {
      return dark;
    } else {
      return light;
    }
  }
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        darkTheme: ApplicationTheme.dark,
        theme: ApplicationTheme.light,
        home: const SafeArea(
          child: Lexicon(),
        ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: ApplicationTheme.current.primaryColor),
  );

  await Settings.instance().initialize();
  await Constants.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (_) => Settings.instance(),
      child: const Application(),
    ),
  );
}
