import 'dart:convert';

import 'package:baby_care/Api/api.dart';
import 'package:baby_care/function/doctor.dart';
import 'package:baby_care/function/guide.dart';
import 'package:baby_care/function/profile.dart';
import 'package:baby_care/model/post_model.dart';
import 'package:baby_care/model/userModel.dart';
import 'package:baby_care/screens/post_details.dart';
import 'package:baby_care/screens/post_submission_page.dart';
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
    PostSubmissionPage(),
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
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
            ),
            label: 'Doctor List',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.post_add,
            ),
            label: 'Post',
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
    );
  }

  Widget _postWidget(PostModel postModel, String docId) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostDetails(
                    postModel: postModel,
                    docId: docId,
                  )),
        );
      },
      leading: StreamBuilder(
          stream: AppApi.firestore
              .collection('users')
              .doc(postModel.userId.trim())
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
        postModel.postedBy,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postModel.details,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
              stream: AppApi.getPostsComments(docId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const SizedBox();
                  case ConnectionState.done:
                  case ConnectionState.active:
                    return Text('${snapshot.data?.size ?? 0} replies');
                }
              })
        ],
      ),
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
