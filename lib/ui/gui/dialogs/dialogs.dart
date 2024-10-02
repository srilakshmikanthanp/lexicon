import 'package:flutter/material.dart';
import 'package:lexicon/ui/gui/components/scanner.dart';

Future<bool> showYesOrNoDialog(BuildContext context, String message) async {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop(false);
    },
  );
  Widget yesButton = ElevatedButton(
    child: const Text("Yes"),
    onPressed: () {
      Navigator.of(context).pop(true);
    },
  ); // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Do you want to continue?"),
    content: Text(message),
    actions: [
      cancelButton,
      yesButton,
    ],
  ); // show the dialog
  final result = await showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  return result ?? false;
}

Future<List<String>?> showScanDialog(BuildContext context) async {
  var dialog = Dialog(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Add More Images from Camera or Gallery"),
          Scanner(onScanned: (res) => Navigator.pop(context, res))
        ],
      ),
    ),
  );

  final result = await showDialog<List<String>?>(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );

  return result;
}
