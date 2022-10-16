import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kairma/global/app_theme.dart';
import 'package:kairma/pages/create_message_page.dart';
import 'package:kairma/pages/display_message_page.dart';
import 'package:kairma/pages/home_page.dart';
import 'package:kairma/pages/profile_page.dart';
import 'package:kairma/pages/sign_in_page.dart';
import 'package:kairma/pages/sign_up_page.dart';

bool signedIn = false;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Care-ma',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: createMaterialColor(const Color(0xFFFFB7B3)),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
          textTheme: TextTheme(
            bodyText2: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.secondary),
          ),
          iconTheme: const IconThemeData(color: AppTheme.secondary)),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/display': (context) => const DisplayMessagePage(),
        '/create': (context) => const CreateMessagePage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  ;
  return MaterialColor(color.value, swatch);
}
