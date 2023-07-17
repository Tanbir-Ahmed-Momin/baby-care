import 'dart:convert';

import 'package:baby_care/Api/api.dart';
import 'package:baby_care/auth/login.dart';
import 'package:baby_care/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/userModel.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        if (FirebaseAuth.instance.currentUser != null) {
          AppApi.firestore
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) {
            UserModel userModel = UserModel.fromJson(value.data()!);
            AppApi.currentUserModel = userModel;
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>
                      HomePage(userModel: UserModel.fromJson(value.data()!)),
                ),
                (route) => false);
          });
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const login(),
              ),
              (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("image/BabyCare.jpg"), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
