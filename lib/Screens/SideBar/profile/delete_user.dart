import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaisi_app/Screens/AuthentificationF/Login/login_screen.dart';
import 'package:kaisi_app/utilities/Dialogs/generic_dialogs.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Supprimer le compte',
    content: 'Êtes-vous sûr de vouloir supprimer votre compte ?',
    optionsBuilder: () => {
      'Annuler': false,
      'Supprimer le compte': true,
    },
  ).then(
    (value) async {
      if (value == true) {
        // Call delete user account function here
        bool success = await deleteUserAccount(context);
        if (success) {
          // Account deleted successfully, navigate to login screen or home screen
          // Replace the code below with the appropriate navigation logic
          Navigator.of(context).popUntil((route) => route.isFirst);
          // You can navigate to any screen after account deletion
        } else {
          // Failed to delete account, show error message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Échec de la suppression du compte. Veuillez réessayer.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
      return value ?? false;
    },
  );
}

Future<bool> deleteUserAccount(BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();
      // Account deleted successfully, navigate to login screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
      return true;
    } else {
      // No user signed in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Utilisateur non connecté.'),
          duration: Duration(seconds: 3),
        ),
      );
      return false;
    }
  } catch (e) {
    // An error occurred
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Oh Zut! ${e.toString()}'),
        duration: const Duration(seconds: 3),
      ),
    );
    return false;
  }
}
