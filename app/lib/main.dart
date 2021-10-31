import 'package:eva_fall_detection_care_taker/home_page.dart';
import 'package:eva_fall_detection_care_taker/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eva Care Taker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
            GoogleFonts.varelaRoundTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        primaryColor: Color(0xFF535FFD),
      ),
      home: OnboardingScreen(),
    );
  }
}
