import 'package:flutter/material.dart';
import 'package:lexicon/filters/filters.dart';
import 'package:lexicon/settings/settings.dart';
import 'package:provider/provider.dart';

Future<bool> filter(BuildContext ctx, String word) async {
  var settings = Provider.of<Settings>(ctx, listen: false);
  var filters = Filters.build(Locale(settings.language));
  if (settings.canFilterWords && await filters.isStopWord(word)) {
    return false;
  } else if (await filters.isEmptyWord(word)) {
    return false;
  } else if (await filters.isNonWord(word)) {
    return false;
  } else {
    return true;
  }
}
