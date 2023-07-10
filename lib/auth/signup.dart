import 'package:baby_care/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../Api/api.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final emailController = TextEditingController() ;
  final passController = TextEditingController() ;
  final nameController = TextEditingController() ;
  @override
  void dispose()
  {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
   double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFB226B2), Color(0xFFFF6DA7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            left: -getBiglDiameter(context) / 4,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              child: const Center(
                child: Text(
                  "Baby Care",
                  style: TextStyle(
                      // fontFamily: "Pacifico",
                      fontSize: 40,
                      color: Colors.white),
                ),
              ),
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFB226B2), Color(0xFFFF4891)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            right: -getBiglDiameter(context) / 2,
            bottom: -getBiglDiameter(context) / 2,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFF3E9EE)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: Column(
                    children:  <Widget>[
                       //TextFieldInput(textEditingController: textEditingController, hintText: hintText, textInputType: textInputType),
                        TextField(
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.person,
                              color: Color(0xFFFF4891),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100 )),
                            labelText: "Name",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      SizedBox(height: 10,),
                       TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.email,
                              color: Color(0xFFFF4891),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100 )),
                            labelText: "Email",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.vpn_key,
                              color: Color(0xFFFF4891),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: "Password",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                            
                      )
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFB226B2),
                                    Color(0xFFFF4891)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: ()async {
                                try{
                                  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passController.text.trim());
                                  await AppApi.firebaseAuth.currentUser!.updateDisplayName(nameController.text.isEmpty?'Guest':nameController.text);
                                  emailController.clear();
                                  passController.clear();
                                  nameController.clear();
                                  const snackBar =  SnackBar(
                                    content: Text("Account created successfully"),
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                } on FirebaseAuthException catch  (e){
                                  final snackBar = SnackBar(
                                    content: Text("Error: ${e.message??''}"),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }

                              },
                              child: const Center(
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // FloatingActionButton(
                      //   onPressed: () {},
                      //   mini: true,
                      //   elevation: 0,
                      //   child: const Image(
                      //     image: AssetImage("assets/facebook2.png"),
                      //   ),
                      // ),
                      // FloatingActionButton(
                      //   onPressed: () {},
                      //   mini: true,
                      //   elevation: 0,
                      //   child: const Image(
                      //     image: AssetImage("assets/twitter.png"),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      " HAVE AN ACCOUNT ? ",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ), 
                    TextButton(
                   onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => login()),
                       );
                   },
                  child:  Text(
                      " SIGN IN",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFFFF4891),
                          fontWeight: FontWeight.w700),
                    ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );;
  }
}