import 'package:flutter/material.dart';
import 'package:lexicon/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  void _onIssueReport() async {
    await launchUrl(Uri.parse(Constants.appIssuesPage));
  }

  void _onWebsiteOpen() async {
    await launchUrl(Uri.parse(Constants.appHomePage));
  }

  void _onDonation() async {
    await launchUrl(Uri.parse(Constants.appDonatePage));
  }

  String _getVersion() {
    return "Version ${Constants.version}";
  }

  void _showLicenses(BuildContext context) {
    showLicensePage(
      applicationVersion: Constants.version,
      applicationName: Constants.appName,
      context: context,
    );
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
        Constants.appLogoAsset,
        height: 60,
        width: 60,
      ),
      const SizedBox(height: 10),
      Text(Constants.appName),
      Text(_getVersion()),
      const SizedBox(height: 10),
      Text(
        Constants.appAppSlogan,
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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // A Horizontal gap from the top and the content
          const SizedBox(height: 50),

          // Card with logo, version, and description
          SizedBox(
            width: double.infinity,
            child: Card.filled(
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
            onTap: () => _showLicenses(context),
            child: const SizedBox(
              width: double.infinity,
              child: Card.filled(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Open Sources Licenses"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
