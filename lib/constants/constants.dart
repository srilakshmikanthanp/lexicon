import 'package:package_info_plus/package_info_plus.dart';

class Constants {
  static late PackageInfo _packageInfo;

  static Future<void> initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  static String get appMajorVersion {
    return version.split(".")[0];
  }

  static String get appMinorVersion {
    return version.split(".")[1];
  }

  static String get appPatchVersion {
    return version.split(".")[2];
  }

  static String get version {
    return _packageInfo.version;
  }

  static String get appName {
    return _packageInfo.appName;
  }

  static String get appIssuesPage {
    return 'https://github.com/srilakshmikanthanp/lexicon/issues';
  }

  static String get appDonatePage {
    return 'https://donate.srilakshmikanthanp.com/';
  }

  static String get appHomePage {
    return 'https://github.com/srilakshmikanthanp/lexicon';
  }

  static String get appStopWordsAsset {
    return 'assets/json/stopwords.json';
  }

  static String get appLogoAsset {
    return 'assets/images/logo.png';
  }

  static String get appAppSlogan {
    return "Reading a Physical book! Searching for Meaning Frequently! Then Lexicon is for You!";
  }

  static List<String> get supportedLanguages {
    return ["en"];
  }
}
