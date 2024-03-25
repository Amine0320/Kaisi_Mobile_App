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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20), // Add spacing at the top
            _buildSection(
              title: 'Plan d\'action',
              image: 'assets/CoachImages/PaImage.png',
              onPressed: () {
                Navigator.of(context).pushNamed(planActionMainScreenRoute);
              },
            ),
            const SizedBox(height: 20), // Add spacing between sections
            _buildSection(
              title: 'Maux',
              image: 'assets/CoachImages/MImage.png',
              onPressed: () {
                Navigator.of(context).pushNamed(mauxMainScreenRoute);
              },
            ),
            const SizedBox(height: 20), // Add spacing between sections
            _buildSection(
              title: 'Situation',
              image: 'assets/CoachImages/SImage.png',
              onPressed: () {
                Navigator.of(context).pushNamed(situationMainScreenRoute);
              },
            ),
            const SizedBox(height: 20), // Add spacing at the bottom
          ],
        ),
      ),
    );
  }

  Widget _buildSection({String? title, String? image, Function? onPressed}) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100, // Adjust width as needed
            height: 100, // Adjust height as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image ?? ''),
              ),
            ),
          ),
          const SizedBox(width: 12), // Add spacing between image and text
          Text(title ?? ''),
        ],
      ),
    );
  }
}
