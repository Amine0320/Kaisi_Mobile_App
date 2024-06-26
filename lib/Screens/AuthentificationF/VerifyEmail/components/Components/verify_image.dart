import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/constants/colors.dart';

class VerifyScreenImage extends StatelessWidget {
  const VerifyScreenImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Veuillez vérifier votre e-mail",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset("assets/images/VerifyImage.jpg"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
