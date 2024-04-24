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
                _buildRoundedMenuItem(
                  text: 'Coach',
                  onPressed: () =>
                      Navigator.pushNamed(context, coachScreenRoute),
                ),
                const SizedBox(width: 20),
                _buildRoundedMenuItem(
                  text: 'Contact',
                  onPressed: () =>
                      Navigator.pushNamed(context, contactScreenRoute),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildRoundedMenuItem(
                    text: 'Compte',
                    onPressed: () =>
                        Navigator.pushNamed(context, profileScreenRoute),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildRoundedMenuItem(
                    text: 'Ateliers',
                    onPressed: () {
                      // Ateliers page here
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            _buildRoundedMenuItem(
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

  Widget _buildRoundedMenuItem(
      {required String text, required Function onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Material(
        color: Colors.transparent, // Remove button color
        child: InkWell(
          onTap: () => onPressed(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
