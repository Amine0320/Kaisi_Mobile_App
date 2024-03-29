import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/Dialogs/generic_dialogs.dart';

Future<void> feedBackDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'Retour soumis',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
