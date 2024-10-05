import 'package:flutter/material.dart';
import 'package:lexicon/models/read/read.dart' as models;
import 'package:lexicon/ui/gui/screens/aboutus/aboutus.dart';
import 'package:lexicon/ui/gui/screens/read/read.dart';
import 'package:lexicon/ui/gui/screens/settings/settings.dart';
import 'package:provider/provider.dart';

class Lexicon extends StatefulWidget {
  const Lexicon({super.key});

  @override
  State<StatefulWidget> createState() => _Lexicon();
}

class _Lexicon extends State<Lexicon> {
  final PageStorageBucket _bucket = PageStorageBucket();
  int _selectedIndex = 0;

  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigation = NavigationBar(
      onDestinationSelected: _handleNavigation,
      selectedIndex: _selectedIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.book),
          icon: Icon(Icons.book_outlined),
          label: 'Read',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.settings),
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.info),
          icon: Icon(Icons.info_outline),
          label: 'About',
        ),
      ],
    );

    const screens = [
      Read(), Settings(), AboutUs()
    ];

    return Scaffold(
      bottomNavigationBar: navigation,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => models.Read.empty()),
        ],
        child: screens[_selectedIndex]
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
