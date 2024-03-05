import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/generic_dialogs.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'log Out',
    content: 'Are you sure you want to log out ? ',
    optionsBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
