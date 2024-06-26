import 'package:flutter/material.dart';

typedef CloseDialog = void Function();
CloseDialog showLoadingDialog({
  required BuildContext context,
  required String text,
}) {
  final dialog = AlertDialog(
    content: Column(mainAxisSize: MainAxisSize.min, children: [
      const CircularProgressIndicator(),
      const SizedBox(
        height: 10.0,
      ),
      Text(text),
    ]),
  );
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => dialog,
    //cancel button for better user experience
  );

  return () => Navigator.of(context).pop();
}


// import 'package:flutter/material.dart';
// import 'package:kaisi_app/Screens/popups/full_screen_loader.dart';

// typedef CloseDialog = void Function();
// CloseDialog showLoadingDialog({
//   required BuildContext context,
//   required String text,
// }) {
//   TFullScreenLoader.openLoadingDialog(text);
//   return () => TFullScreenLoader.stopLoading();
// }
