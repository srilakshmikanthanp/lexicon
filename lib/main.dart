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
    return const Layout(
      child: MaterialApp(
        home: Scaffold(
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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Settings.instance()),
      ],
      child: const Application(),
    ),
  );
}
