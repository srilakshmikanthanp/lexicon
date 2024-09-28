import 'package:package_info_plus/package_info_plus.dart';

class Constants {
  static final Constants _instance = Constants._internal();
  late final PackageInfo _packageInfo;

  factory Constants.instance() {
    return _instance;
  }

  Constants._internal();

  Future<void> initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  String get appMajorVersion {
    return version.split(".")[0];
  }

  String get appMinorVersion {
    return version.split(".")[1];
  }

  String get appPatchVersion {
    return version.split(".")[2];
  }

  String get version {
    return _packageInfo.version;
  }

  String get appName {
    return _packageInfo.appName;
  }

  String get appIssuesPage {
    return 'https://github.com/srilakshmikanthanp/lexicon/issues';
  }

  String get appDonatePage {
    return 'https://donate.srilakshmikanthanp.com/';
  }

  String get appHomePage {
    return 'https://github.com/srilakshmikanthanp/lexicon';
  }

  String get appStopWordsAsset {
    return 'assets/json/stopwords.json';
  }

  String get appLogoAsset {
    return 'assets/images/logo.png';
  }

  String get appAppSlogan {
    return "Reading a Physical book! Searching for Meaning Frequently! Then Lexicon is for You!";
  }

  List<String> get supportedLanguages {
    return ["en"];
  }
}
