import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/Dialogs/generic_dialogs.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Supprimer',
    content: "Êtes-vous sûr de vouloir supprimer l'élément ?",
    optionsBuilder: () => {
      'Annuler': false,
      'Oui': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
