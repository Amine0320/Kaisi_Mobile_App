import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/Dialogs/generic_dialogs.dart';

Future<void> messageDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'Formulaire soumis avec succès.',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
