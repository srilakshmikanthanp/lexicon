import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:lexicon/constants/constants.dart';
import 'package:lexicon/settings/settings.dart';
import 'package:lexicon/ui/gui/lexicon.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        title: 'Lexicon',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const Scaffold(
          body: SafeArea(
            child: Lexicon(),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Settings.instance().initialize();
  await Constants.instance().initialize();
  runApp(const Application());
}
