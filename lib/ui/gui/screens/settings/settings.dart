import 'package:flutter/material.dart';
import 'package:lexicon/constants/constants.dart';
import 'package:lexicon/settings/settings.dart' as prefs;
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var lexiconContent = Column(children: [
      Image.asset(
        Constants.appLogoAsset,
        width: 60,
        height: 60,
      ),
      const SizedBox(height: 10),
      Text(Constants.appName),
      Text(Constants.version),
      const SizedBox(height: 5),
      Text(
        "Let's Make ${Constants.appName} to Work in your Way",
        textAlign: TextAlign.center,
      ),
    ]);

    var canFilterWords = Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Filter words"),
            Text(
              "Filters Stop Words",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            )
          ],
        ),
        const Spacer(),
        Consumer<prefs.Settings>(
          builder: (context, settings, child) {
            return Switch(
              onChanged: (value) async => settings.setCanFilterWords(value),
              value: settings.canFilterWords,
            );
          },
        ),
      ],
    );

    var language = Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Language"),
            Text(
              "Lexicon Language",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            )
          ],
        ),
        const Spacer(),
        Consumer<prefs.Settings>(
          builder: (context, settings, child) {
            return DropdownButton(
              items: Constants.supportedLanguages.map((val) {
                return DropdownMenuItem(value: val, child: Text(val));
              }).toList(),
              onChanged: (String? value) {
                if (value != null) settings.setLanguage(value);
              },
              padding: const EdgeInsets.all(10),
              value: settings.language,
            );
          },
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // A Horizontal gap from the top and the content
          const SizedBox(height: 50),

          // logo, version
          SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: lexiconContent,
              ),
            ),
          ),

          // A Small Gap
          const SizedBox(height: 50),

          // Can filter words
          canFilterWords,

          // Language of Books
          language,
        ],
      ),
    );
  }
}
