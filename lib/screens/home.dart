import 'package:baby_care/function/doctor.dart';
import 'package:baby_care/function/guide.dart';
import 'package:baby_care/function/profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
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
        title: Text('Baby Care'),
        backgroundColor: Color(0xFFFF4891),
        actions: [
          IconButton(
            icon: Image.asset("image/tasp.jpeg"),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => Profile()),
                       );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Doctor List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Guidelines',
          ),
        ],
      ),
    );
  }
}
class Post {
  final String title;
  final String details;
  final String username;
  final String postTime;

  Post({
    required this.title,
    required this.details,
    required this.username,
    required this.postTime,
  });
}

class PostPage extends StatelessWidget {

   final List<Post> posts = [
    Post(
      title: 'What is Pneumonia',
      details: 'Pneumonia is a form of acute respiratory infection that affects the lungs. The lungs are made up of small sacs called alveoli, which fill with air when a healthy person breathes. ',
      username: 'Taspira',
      postTime: 'June 18, 2023',
    ),
    Post(
      title: 'Second Post',
      details: 'This is the second post',
      username: 'JaneSmith',
      postTime: 'June 19, 2023',
    ),
    Post(
      title: 'Second Post',
      details: 'This is the second post',
      username: 'JaneSmith',
      postTime: 'June 19, 2023',
    ),
    Post(
      title: 'Second Post',
      details: 'This is the second post',
      username: 'JaneSmith',
      postTime: 'June 19, 2023',
    ),
    Post(
      title: 'Second Post',
      details: 'This is the second post',
      username: 'JaneSmith',
      postTime: 'June 19, 2023',
    ),
    Post(
      title: 'Second Post',
      details: 'This is the second post',
      username: 'JaneSmith',
      postTime: 'June 19, 2023',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
         Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Write your post here',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0), // Adding some vertical spacing
          ElevatedButton(
            
            onPressed: () {
              // Handle the submit button press here
              // You can access the text input using a TextEditingController
            },
            style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 244, 54, 244), // Replace with the desired color
  ),
            child: Text('Post'),
          ),
        ],
      ),
    ),
    //  Expanded(
    //         child: ListView.builder(
    //           itemCount: 10, // Replace with the actual number of organizations
    //           itemBuilder: (context, index) {
    //             return GestureDetector(
    //               onTap: () {
    //                 showDialog(
    //                   context: context,
    //                   builder: (context) {
    //                     return AlertDialog(
    //                       contentPadding: EdgeInsets.all(16),
    //                       content: Column(
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: [
    //                           CircleAvatar(
    //                             radius: 50,
    //                             backgroundImage: AssetImage('image/demo.png'),
    //                           ),
    //                           SizedBox(height: 16),
    //                           Text(
    //                             'Organization Name $index',
    //                             style: TextStyle(
    //                               fontSize: 18,
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                       actions: [
    //                         TextButton(
    //                           child: Text('Close'),
    //                           onPressed: () {
    //                             Navigator.of(context).pop();
    //                           },
    //                         ),
    //                       ],
    //                     );
    //                   },
    //                 );
    //               },
    //               child: Container(
    //                 margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //                 padding: EdgeInsets.all(16),
    //                 decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: BorderRadius.circular(10),
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Colors.grey.withOpacity(0.3),
    //                       spreadRadius: 2,
    //                       blurRadius: 5,
    //                       offset: Offset(0, 3),
    //                     ),
    //                   ],
    //                 ),
    //                 child: ListTile(
    //                   leading: CircleAvatar(
    //                     backgroundImage: AssetImage('image/demo.png'),
    //                   ),
    //                   title: Text('Organization Name $index'),
    //                   trailing: Icon(
    //                     Icons.arrow_forward,
    //                     color: Colors.blue,
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       ),
     Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(16),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage('image/demo.png'),
                              ),
                              SizedBox(height: 16),
                              Text(
                                post.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text('Details: ${post.details}'),
                              SizedBox(height: 8),
                              Text('Username: ${post.username}'),
                              SizedBox(height: 8),
                              Text('Post Time: ${post.postTime}'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('image/demo.png'),
                      ),
                      title: Text(post.title),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: Color.fromARGB(255, 243, 33, 222),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
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
