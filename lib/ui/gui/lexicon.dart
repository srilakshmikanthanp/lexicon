import 'package:flutter/material.dart';
import 'package:lexicon/ui/gui/screens/aboutus.dart';
import 'package:lexicon/ui/gui/screens/read.dart';
import 'package:lexicon/ui/gui/screens/settings.dart';

class Lexicon extends StatefulWidget {
  const Lexicon({super.key});

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Lexicon> {
  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

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

    final screens = [
      const Read(),
      const Settings(),
      const AboutUs(),
    ];

    return Scaffold(
      bottomNavigationBar: navigation,
      body: screens[_selectedIndex],
      resizeToAvoidBottomInset: false,
    );
  }
}
