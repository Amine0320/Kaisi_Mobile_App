import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/constants/routes.dart';

class MauxMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF90CAF9), // Set background color for AppBar
      ),
      backgroundColor:
          const Color(0xFF90CAF9), // Set background color for Scaffold
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Un Maux',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Aujourd'hui, je prends les choses en main",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, mauxScreenRoute);
                },
                child: const Text('Demarrer'),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 100,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  'assets/CoachImages/SMScreenImage.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
