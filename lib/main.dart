import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:layout/layout.dart';
import 'package:lexicon/constants/constants.dart';
import 'package:lexicon/settings/settings.dart';
import 'package:lexicon/ui/gui/lexicon.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Application();
  }
}

class _Application extends State<Application> with WidgetsBindingObserver {
  @override
  void initState() {
    var schedulerBinding = SchedulerBinding.instance;
    var dispatcher = schedulerBinding.platformDispatcher;
    brightness = dispatcher.platformBrightness;
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    var schedulerBinding = SchedulerBinding.instance;
    var dispatcher = schedulerBinding.platformDispatcher;

    setState(() {
      brightness = dispatcher.platformBrightness;
    });
  }

  late Brightness brightness;

  bool isDarkTheme() {
    if (brightness == Brightness.dark) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData.light(useMaterial3: true);
    final darkTheme = ThemeData.dark(useMaterial3: true);

    final light = SystemUiOverlayStyle(
      statusBarColor: lightTheme.canvasColor,
      statusBarIconBrightness: Brightness.dark,
    );

    final dark = SystemUiOverlayStyle(
      statusBarColor: darkTheme.canvasColor,
      statusBarIconBrightness: Brightness.light,
    );

    final region = AnnotatedRegion(
      value: isDarkTheme() ? dark : light,
      child: const Lexicon(),
    );

    return Layout(
      child: MaterialApp(
        darkTheme: darkTheme,
        theme: lightTheme,
        home: SafeArea(child: region),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Settings.instance().initialize();
  await Constants.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (_) => Settings.instance(),
      child: const Application(),
    ),
  );
}
