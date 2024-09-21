import 'package:flutter/material.dart';
import 'package:lexicon/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  void _onIssueReport() async {
    await launchUrl(Uri.parse(Constants.instance().appIssuesPage));
  }

  void _onWebsiteOpen() async {
    await launchUrl(Uri.parse(Constants.instance().appHomePage));
  }

  void _onDonation() async {
    await launchUrl(Uri.parse(Constants.instance().appDonatePage));
  }

  String _getVersion() {
    return "Version ${Constants.instance().version}";
  }

  Widget _buildActionIcon({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: () async => onPressed(),
      child: Column(
        children: [
          Icon(icon, size: 30),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var aboutUsContent = Column(children: [
      Image.asset(
        Constants.instance().appLogoAsset,
        height: 60,
        width: 60,
      ),
      const SizedBox(height: 10),
      Text(_getVersion()),
      const SizedBox(height: 30),
      Text(
        Constants.instance().appAppSlogan,
        textAlign: TextAlign.center,
      ),
    ]);

    var actions = [
      _buildActionIcon(
        context: context,
        icon: Icons.language,
        label: "Website",
        onPressed: () async => _onWebsiteOpen(),
      ),
      _buildActionIcon(
        context: context,
        icon: Icons.bug_report,
        label: "Report Issue",
        onPressed: () async => _onIssueReport(),
      ),
      _buildActionIcon(
        context: context,
        icon: Icons.attach_money,
        label: "Donate",
        onPressed: () async => _onDonation(),
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // A Horizontal gap from the top and the content
            const SizedBox(height: 50),

            // Card with logo, version, and description
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: aboutUsContent,
                ),
              ),
            ),

            // A Small Gap
            const SizedBox(height: 50),

            // Icons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: actions,
            ),

            // A Small Gap
            const SizedBox(height: 50),

            // License
            GestureDetector(
              onTap: () => showLicensePage(context: context),
              child: const SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("Open Sources Licenses"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
