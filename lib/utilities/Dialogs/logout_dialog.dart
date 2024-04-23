import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/Dialogs/generic_dialogs.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'lSe deconnecter',
    content: 'Êtes-vous sûr de vouloir vous déconnecter ? ',
    optionsBuilder: () => {
      'Annuler': false,
      'Se deconnecter': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
