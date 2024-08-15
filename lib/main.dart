import 'package:flutter/material.dart';
import 'package:noteswap/screens/search_notes_screen.dart';
import 'package:noteswap/screens/onboarding_intro_screen.dart';
import 'package:noteswap/screens/onboarding_slides_screen.dart';
import 'package:noteswap/screens/feed_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SafeArea(
        child: FeedScreen(), // Remove 'const' here
      ),
    );
  }
}
