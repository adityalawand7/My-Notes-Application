import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text){
  return ShowGenericDialog<void>(
    context: context,
    title: "An error occured",
    content: text,
    optionsBuilder: () => {
      "OK": null,
    },
  );
}