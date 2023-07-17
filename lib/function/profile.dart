import 'package:baby_care/model/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Api/api.dart';
import '../auth/login.dart';
import '../model/userModel.dart';

class Profile extends StatefulWidget {
  final UserModel userModel;
  const Profile({Key? key, required this.userModel}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _commonController = TextEditingController();

  Future<void> editProfileField(
      {required String title, required EditTypes type}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update $title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _commonController,
                  keyboardType: type == EditTypes.number
                      ? TextInputType.number
                      : TextInputType.text,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                _commonController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('update'),
              onPressed: () async {
                switch (type) {
                  case EditTypes.name:
                    await AppApi.updateProfileName(
                      name: _commonController.text,
                    );

                    break;
                  case EditTypes.number:
                    await AppApi.updateProfileNumber(
                      number: _commonController.text,
                    );
                    break;
                  case EditTypes.address:
                    await AppApi.updateProfileAddress(
                      address: _commonController.text,
                    );
                    break;
                  case EditTypes.email:
                    try {
                      await AppApi.firebaseAuth.currentUser!.updateEmail(
                        _commonController.text,
                      );
                    } on FirebaseAuthException catch (e) {
                      final snackBar = SnackBar(
                        content: Text("Error: ${e.message ?? ''}"),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    break;
                }
                _commonController.clear();
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _commonController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Logout button action
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login(),
                  ),
                  (route) => false);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: FutureBuilder(
              future: AppApi.firestore
                  .collection('users')
                  .doc(widget.userModel.uid)
                  .get(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                  case ConnectionState.active:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              widget.userModel.photoUrl,
                              width: 120.0,
                              height: 120.0,
                            ),
                            Positioned(
                                top: -10,
                                right: -10,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit)))
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Name',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            IconButton(
                                onPressed: () {
                                  editProfileField(
                                    title: 'Name',
                                    type: EditTypes.name,
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18.0,
                                ))
                          ],
                        ),
                        Text(
                          snapshot.data!.get('name'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Number',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18.0,
                                ))
                          ],
                        ),
                        Text(
                          snapshot.data!.get('phone'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18.0,
                                ))
                          ],
                        ),
                        Text(
                          snapshot.data!.get('address'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18.0,
                                ))
                          ],
                        ),
                        Text(
                          AppApi.firebaseAuth.currentUser!.email ?? 'Guest',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    );
                }
              })),
    );
  }
}

enum EditTypes { name, number, address, email }
