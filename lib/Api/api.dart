import 'dart:convert';

import 'package:baby_care/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppApi{

  //firebase auth instance
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // firestore instance
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get post
  static Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return firestore
        .collection('posts').snapshots();
  }

  //post posts
  static Future<void> postAPost(PostModel postModel){
      return firestore.collection('posts').doc().set(
        postModel.toJson()
      );
  }
  //delete post
  static Future<void> deleteAPost({required String docId}){
    return firestore.collection('posts').doc(docId).delete();
  }

  // get doctors
  static Stream<QuerySnapshot<Map<String, dynamic>>> getDoctors() {
    return firestore
        .collection('doctors').snapshots();
  }

  // get guidelines
  static Stream<QuerySnapshot<Map<String, dynamic>>> getGuideLines() {
    return firestore
        .collection('guidelines').snapshots();
  }

}