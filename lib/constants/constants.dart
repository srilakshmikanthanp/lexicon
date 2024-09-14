import 'package:package_info_plus/package_info_plus.dart';

Future<String> appMajorVersion() async {
  return (await version()).split(".")[0];
}

Future<String> appMinorVersion() async {
  return (await version()).split(".")[1];
}

Future<String> appPatchVersion() async {
  return (await version()).split(".")[2];
}

Future<String> version() async {
  return (await PackageInfo.fromPlatform()).version;
}

Future<String> appName() async {
  return (await PackageInfo.fromPlatform()).appName;
}

Future<String> appIssuesPage() async {
  return 'https://github.com/srilakshmikanthanp/lexicon/issues';
}

Future<String> appDonatePage() async {
  return 'https://donate.srilakshmikanthanp.com/';
}

Future<String> appHomePage() async {
  return 'https://github.com/srilakshmikanthanp/lexicon';
}
