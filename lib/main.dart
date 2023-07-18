import 'package:baby_care/auth/login.dart';
import 'package:baby_care/screens/home.dart';
import 'package:baby_care/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Baby Care",
      theme: ThemeData(
          useMaterial3: true,
          bottomNavigationBarTheme:const BottomNavigationBarThemeData(
            unselectedLabelStyle: TextStyle(
              fontFamily: 'pacifico',
            ),
            selectedLabelStyle: TextStyle(
              fontFamily: 'pacifico',
            )
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4891),
            foregroundColor: Colors.white,
          )),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFF4891),
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(
              fontFamily: 'pacifico',
              fontSize: 18.0
            )
          ),
          inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Color(0xFFFF4891)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF4891))))),
      home: const splash(),
    );
  }
}
