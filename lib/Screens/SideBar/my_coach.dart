import 'package:flutter/material.dart';

class CoachScreen extends StatefulWidget {
  final String? title;

  const CoachScreen({Key? key, this.title}) : super(key: key);

  @override
  _CoachScreenState createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Coach'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSection(
              title: 'Plan d\'action',
              image: 'assets/images/plan_action.png',
              onPressed: () {
                // Action du bouton "Plan d'action"
              },
            ),
            _buildSection(
              title: 'Maux',
              image: 'assets/images/maux.png',
              onPressed: () {
                // Action du bouton "Maux"
              },
            ),
            _buildSection(
              title: 'Situation',
              image: 'assets/images/situation.png',
              onPressed: () {
                // Action du bouton "Situation"
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({title, image, onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Image.asset(image),
          Text(title),
        ],
      ),
    );
  }
}
