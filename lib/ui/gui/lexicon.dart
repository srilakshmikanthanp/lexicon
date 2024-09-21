import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:lexicon/ui/gui/screens/aboutus/aboutus.dart';

class Lexicon extends StatefulWidget {
  const Lexicon({super.key});

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Lexicon> {
  Widget _smallWidget(BuildContext context) {
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
      const Text(""),
      const Text(""),
      const AboutUs(),
    ];

    return Scaffold(
      bottomNavigationBar: navigation,
      body: screens[_selectedIndex],
    );
  }

  Widget _largeWidget(BuildContext context) {
    return _smallWidget(context);
  }

  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (context.breakpoint > LayoutBreakpoint.md) {
      return _largeWidget(context);
    } else {
      return _smallWidget(context);
    }
  }
}
