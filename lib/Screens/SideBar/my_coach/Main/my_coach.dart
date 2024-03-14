import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/constants/routes.dart';

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
        title: const Text('Mon Coach'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSection(
              title: 'Plan d\'action',
              image: 'assets/images/plan_action.png',
              onPressed: () {
                Navigator.of(context).pushNamed(planActionScreenRoute);
              },
            ),
            _buildSection(
              title: 'Maux',
              image: 'assets/images/maux.png',
              onPressed: () {
                Navigator.of(context).pushNamed(mauxScreenRoute);
              },
            ),
            _buildSection(
              title: 'Situation',
              image: 'assets/images/situation.png',
              onPressed: () {
                Navigator.of(context).pushNamed(situationScreenRoute);
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
