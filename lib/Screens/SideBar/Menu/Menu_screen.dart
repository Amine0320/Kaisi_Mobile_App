import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/constants/routes.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF90CAF9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedMenuItem(
                  text: 'Coach',
                  onPressed: () {
                    Navigator.pushNamed(context, coachScreenRoute);
                  },
                ),
                const SizedBox(width: 20),
                RoundedMenuItem(
                  text: 'Contact',
                  onPressed: () {
                    Navigator.pushNamed(context, contactScreenRoute);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RoundedMenuItem(
                    text: 'Compte',
                    onPressed: () {
                      Navigator.pushNamed(context, profileScreenRoute);
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: RoundedMenuItem(
                    text: 'Ateliers',
                    onPressed: () {
                      // Ateliers page here
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            RoundedMenuItem(
              text: 'Historique',
              onPressed: () {
                // Historique page here
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedMenuItem extends StatelessWidget {
  final String text;
  final Function onPressed;

  const RoundedMenuItem({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
