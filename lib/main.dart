import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:lexicon/constants/constants.dart';
import 'package:lexicon/settings/settings.dart';
import 'package:lexicon/ui/gui/lexicon.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    var lightThemeData = ThemeData.light(useMaterial3: true).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: ThemeData.light(useMaterial3: true).colorScheme.onSurface
      ),
    );

    var darkThemeData = ThemeData.dark(useMaterial3: true).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: ThemeData.light(useMaterial3: true).colorScheme.onSurface
      ),
    );

    return Layout(
      child: MaterialApp(
        darkTheme: darkThemeData,
        theme: lightThemeData,
        home: const SafeArea(
          child: Lexicon(),
        ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Settings.instance().initialize();
  await Constants.instance().initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Settings.instance()),
      ],
      child: const Application(),
    ),
  );
}
