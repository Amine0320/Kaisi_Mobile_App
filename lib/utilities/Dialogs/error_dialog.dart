import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/Dialogs/generic_dialogs.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'Une erreur est survenue',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
