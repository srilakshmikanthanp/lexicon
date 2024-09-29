import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/layout.dart';
import 'package:lexicon/constants/constants.dart';
import 'package:lexicon/settings/settings.dart';
import 'package:lexicon/theme.dart' as theme;
import 'package:lexicon/ui/gui/lexicon.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        darkTheme: theme.darkTheme,
        theme: theme.lightTheme,
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
    SystemUiOverlayStyle(statusBarColor: theme.currentTheme.canvasColor),
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
