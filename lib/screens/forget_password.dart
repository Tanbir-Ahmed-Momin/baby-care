import 'package:baby_care/Api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  /// send rest password link to email
  void resetPassword() async {
    if (_emailController.text.isNotEmpty) {
      try {
        await AppApi.firebaseAuth
            .sendPasswordResetEmail(email: _emailController.text);
        _emailController.clear();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email sent. Check your email'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Error: ${e.message ?? ''}',
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: const Color(0xFFFF4891),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
        child: ListView(
          children: [
            Text(
              'Forget Password?',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
                'Enter the email associated with your account and we will send you a link to reset your password.'),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                focusColor: Color(0xFFFF4891),
                labelText: 'Email address',
                hintText: 'e.g m1JtD@example.com',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  resetPassword();
                },
                child: Text('Send'))
          ],
        ),
      ),
    );
  }
}
