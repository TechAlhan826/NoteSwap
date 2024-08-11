import 'package:flutter/material.dart';
import 'dart:async';
import 'package:noteswap/screens/onboarding_slides_screen.dart';

class OnboardingIntroScreen extends StatelessWidget {
  const OnboardingIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Schedule the navigation after 4 seconds
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingSlidesScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnboardingSlidesScreen()),
          );
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to',
                  style: TextStyle(
                    fontFamily: 'ClashDisplayVariable',
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Noteswap',
                  style: TextStyle(
                    fontFamily: 'ClashDisplayVariable',
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Image.asset(
                  'assets/onboarding_intro_image.png',
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 80),
                const Text(
                  'Your Friend in Need',
                  style: TextStyle(
                    fontFamily: 'ClashDisplayVariable',
                    color: Colors.white,
                    fontSize: 32,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
