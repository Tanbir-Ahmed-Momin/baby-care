import 'package:baby_care/auth/login.dart';
import 'package:baby_care/screens/home.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  void initState(){
    super.initState();
    Future.delayed(const Duration(milliseconds: 5000), () {
      setState(() {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const login() ));
      });
    });   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
           constraints: BoxConstraints.expand(),
  decoration: const BoxDecoration(
    image: DecorationImage(
        image: AssetImage("image/BabyCare.jpg"), 
        fit: BoxFit.cover),
  ),
        ),
      );
  }
}