import 'package:baby_care/Api/api.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';

class PostSubmissionPage extends StatefulWidget {
  const PostSubmissionPage({super.key});

  @override
  State<PostSubmissionPage> createState() => _PostSubmissionPageState();
}

class _PostSubmissionPageState extends State<PostSubmissionPage> {
  TextEditingController _postController = TextEditingController();
  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What's in your mind?",
            style: TextStyle(fontSize: 20),
          ),
          const Text('Feel free to share...'),
          const SizedBox(
            height: 15.0,
          ),
          TextField(
            controller: _postController,
            minLines: 4,
            maxLines: 6,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'write here...'),
          ),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
              onPressed: () async {
                var userName = "";
                await AppApi.firestore
                    .collection('users')
                    .doc(AppApi.firebaseAuth.currentUser!.uid)
                    .get()
                    .then((value) {
                  userName = value.get('name');
                });
                var postModel = PostModel(
                    userId: AppApi.firebaseAuth.currentUser!.uid,
                    postedBy: userName ?? 'Guest',
                    details: _postController.text,
                    time: DateTime.now().microsecondsSinceEpoch,
                    title: _postController.text);
                await AppApi.postAPost(postModel);
                _postController.clear();
              },
              child: const Text('post')),
        ],
      ),
    );
  }
}
