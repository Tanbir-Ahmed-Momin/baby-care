import 'package:baby_care/model/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Api/api.dart';
import '../auth/login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _nameController = TextEditingController();
  // TextEditingController _numberController = TextEditingController();
  // TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  // TextEditingController _nidController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = AppApi.firebaseAuth.currentUser!.displayName??'Guest';
    _emailController.text = AppApi.firebaseAuth.currentUser!.email??'';
  }

  @override
  void dispose() {
    _nameController.dispose();
    // _numberController.dispose();
    // _addressController.dispose();
    _emailController.dispose();
    // _nidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6DA7),
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Save button action
              if(_nameController.text.isNotEmpty){
                AppApi.firebaseAuth.currentUser!.updateDisplayName(_nameController.text);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//             Container(
//   height: 80,
//   child: Stack(
//     children: [
//       ClipRRect(
//         borderRadius: BorderRadius.circular(60),
//         child: Container(
//           color: Colors.grey[300],
//           alignment: Alignment.center,
//           child: Icon(
//             Icons.cloud_upload,
//             size: 50,
//             color: Colors.grey[600],
//           ),
//         ),
//       ),
//       Positioned(
//         top: 8,
//         right: 8,
//         child: IconButton(
//           icon: Icon(
//             Icons.photo_camera,
//             size: 24,
//           ),
//           onPressed: () {
//             // Implement image upload functionality here
//           },
//         ),
//       ),
//     ],
//   ),
// ),

          SizedBox(height: 16),
            Text('Name'),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            // SizedBox(height: 16),
            // Text('Number'),
            // TextField(
            //   controller: _numberController,
            //   decoration: InputDecoration(
            //     hintText: 'Enter your number',
            //   ),
            // ),
            // SizedBox(height: 16),
            // Text('Address'),
            // TextField(
            //   controller: _addressController,
            //   decoration: InputDecoration(
            //     hintText: 'Enter your address',
            //   ),
            // ),
            SizedBox(height: 16),
            Text('Email'),
            TextField(
              controller: _emailController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            // SizedBox(height: 16),
            // Text('NID'),
            // TextField(
            //   controller: _nidController,
            //   decoration: InputDecoration(
            //     hintText: 'Enter your NID',
            //   ),
            // ),
            SizedBox(height: 32),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async{
                  // Logout button action
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login(),), (route) => false);
                },
                style: ElevatedButton.styleFrom(
    backgroundColor:Color(0xFFFF6DA7), // Replace with the desired color
  ),
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
