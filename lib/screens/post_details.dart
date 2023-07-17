import 'package:baby_care/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Api/api.dart';

class PostDetails extends StatefulWidget {
  final PostModel postModel;
  final String docId;
  const PostDetails({super.key, required this.postModel, required this.docId});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void postComment() async {
    if (_commentController.text.isNotEmpty) {
      try {
        await AppApi.firestore
            .collection('posts')
            .doc(widget.docId)
            .collection('comments')
            .add({
          'text': _commentController.text,
          'uid': AppApi.firebaseAuth.currentUser!.uid
        });
      } on FirebaseFirestore catch (e) {}
    }
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('back'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            ListTile(
              onTap: () {},
              leading: StreamBuilder(
                  stream: AppApi.firestore
                      .collection('users')
                      .doc(widget.postModel.userId.trim())
                      .snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const SizedBox();
                      case ConnectionState.done:
                      case ConnectionState.active:
                        return ClipOval(
                            child: Image.network(
                          snapshot.data!.get('photoUrl'),
                          width: 30.0,
                          height: 30.0,
                          fit: BoxFit.cover,
                        ));
                    }
                  }),
              titleAlignment: ListTileTitleAlignment.top,
              title: Text(
                widget.postModel.postedBy,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.postModel.details,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 50.0,
              child: TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'write your comment',
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () {
                  postComment();
                },
                child: const Text('comment')),
            const SizedBox(
              height: 15.0,
            ),
            StreamBuilder(
              stream: AppApi.getPostsComments(widget.docId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                  case ConnectionState.active:
                    return ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        leading: StreamBuilder(
                            stream: AppApi.firestore
                                .collection('users')
                                .doc(snapshot.data!.docs[index].data()['uid'])
                                .snapshots(),
                            builder: (context, snapshotPhoto) {
                              switch (snapshotPhoto.connectionState) {
                                case ConnectionState.waiting:
                                case ConnectionState.none:
                                  return const SizedBox();
                                case ConnectionState.done:
                                case ConnectionState.active:
                                  return ClipOval(
                                      child: Image.network(
                                    snapshotPhoto.data!.get('photoUrl'),
                                    width: 30.0,
                                    height: 30.0,
                                    fit: BoxFit.cover,
                                  ));
                              }
                            }),
                        title: StreamBuilder(
                            stream: AppApi.firestore
                                .collection('users')
                                .doc(snapshot.data!.docs[index].data()['uid'])
                                .snapshots(),
                            builder: (context, snapshotName) {
                              switch (snapshotName.connectionState) {
                                case ConnectionState.waiting:
                                case ConnectionState.none:
                                  return const SizedBox();
                                case ConnectionState.done:
                                case ConnectionState.active:
                                  return Text(snapshotName.data!.get('name'),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ));
                              }
                            }),
                        subtitle:
                            Text(snapshot.data!.docs[index].data()['text']),
                        titleAlignment: ListTileTitleAlignment.center,
                      ),
                      itemCount: snapshot.data!.size,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
