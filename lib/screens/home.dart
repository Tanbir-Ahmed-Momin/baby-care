import 'dart:convert';

import 'package:baby_care/Api/api.dart';
import 'package:baby_care/function/doctor.dart';
import 'package:baby_care/function/guide.dart';
import 'package:baby_care/function/profile.dart';
import 'package:baby_care/model/post_model.dart';
import 'package:baby_care/model/userModel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    PostPage(),
    DoctorListPage(),
    GuidelinesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby Care'),
        actions: [
          StreamBuilder(
              stream: AppApi.firestore
                  .collection('users')
                  .doc(AppApi.firebaseAuth.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                  case ConnectionState.active:
                    return IconButton(
                      icon: ClipOval(
                          child: Image.network(
                        snapshot.data!.get('photoUrl'),
                        width: 30.0,
                        height: 30.0,
                        fit: BoxFit.cover,
                      )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      },
                    );
                }
              }),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFFF4891),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.post_add,
            ),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
            ),
            label: 'Doctor List',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'Guidelines',
          ),
        ],
      ),
    );
  }
}

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late TextEditingController _postController;
  late TextEditingController _postTitleController;

  @override
  void initState() {
    super.initState();
    _postController = TextEditingController();
    _postTitleController = TextEditingController();
  }

  @override
  void dispose() {
    _postController.dispose();
    _postTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        children: [
          TextField(
            controller: _postTitleController,
            decoration: const InputDecoration(
              hintText: 'Write your post title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: _postController,
            minLines: 2,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Write your post description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0), // Adding some vertical spacing
          ElevatedButton(
            onPressed: () async {
              if (_postController.text.isNotEmpty &&
                  _postTitleController.text.isNotEmpty) {
                var postModel = PostModel(
                    userId: AppApi.firebaseAuth.currentUser!.uid,
                    postedBy:
                        AppApi.firebaseAuth.currentUser!.displayName ?? 'Guest',
                    details: _postController.text,
                    time: DateTime.now().microsecondsSinceEpoch,
                    title: _postTitleController.text);
                await AppApi.postAPost(postModel);
                _postController.clear();
                _postTitleController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(
                  255, 244, 54, 244), // Replace with the desired color
            ),
            child: Text('Post'),
          ),
          const SizedBox(height: 10.0),

          const Divider(),
          Expanded(
            child: StreamBuilder(
              stream: AppApi.getPosts(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) => _postWidget(
                          PostModel.fromJson(
                            snapshot.data!.docs[index].data(),
                          ),
                          snapshot.data!.docs[index].id,
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No post yet!'),
                      );
                    }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _postWidget(PostModel postModel, String docId) {
    return ListTile(
      onTap: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('${postModel.title} by ${postModel.postedBy}'),
            content: Text(postModel.details),
            actions: [
              if (postModel.userId == AppApi.firebaseAuth.currentUser!.uid)
                IconButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await AppApi.deleteAPost(docId: docId);
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ))
            ],
          ),
        );
      },
      title: Text('${postModel.title} by ${postModel.postedBy}'),
      subtitle: Text(
        postModel.details,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(Icons.more_horiz),
    );
  }
}

class DoctorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: doctor(),
      ),
    );
  }
}

class GuidelinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: guide(),
      ),
    );
  }
}
