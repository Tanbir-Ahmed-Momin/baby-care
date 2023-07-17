import 'dart:convert';

import 'package:baby_care/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppApi {
  //firebase auth instance
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // firestore instance
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get post
  static Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return firestore.collection('posts').snapshots();
  }

  //post posts
  static Future<void> postAPost(PostModel postModel) {
    return firestore.collection('posts').doc().set(postModel.toJson());
  }

  //delete post
  static Future<void> deleteAPost({required String docId}) {
    return firestore.collection('posts').doc(docId).delete();
  }

  // get doctors
  static Stream<QuerySnapshot<Map<String, dynamic>>> getDoctors() {
    return firestore.collection('doctors').snapshots();
  }

  // get guidelines
  static Stream<QuerySnapshot<Map<String, dynamic>>> getGuideLines() {
    return firestore.collection('guidelines').snapshots();
  }

  /// update profile number
  static Future<void> updateProfileNumber({required String number}) {
    return firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'phone': number,
    });
  }

  /// update profile name
  static Future<void> updateProfileName({required String name}) {
    return firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'name': name,
    });
  }

  /// update profile address
  static Future<void> updateProfileAddress({required String address}) {
    return firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'address': address,
    });
  }

  /// update profile uid
  static Future<void> updateProfileUid({required String uId}) {
    return firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'uid': uId,
    });
  }

  static Future<void> createProfile(
      {required String name, required String phone}) {
    return firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'uid': firebaseAuth.currentUser!.uid,
      'name': name,
      'phone': phone,
      'address': 'unknown',
      'photoUrl':
          'https://firebasestorage.googleapis.com/v0/b/babycare-184d3.appspot.com/o/profiles%2Fdefault.jpg?alt=media&token=e5594834-444e-4943-9251-118e94aa62bd'
    });
  }
}
