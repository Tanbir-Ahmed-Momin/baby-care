import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api/api.dart';

class BabySitting extends StatefulWidget {
  const BabySitting({super.key});

  @override
  State<BabySitting> createState() => _BabySittingState();
}

class _BabySittingState extends State<BabySitting> {
  bool isBabySittingActive = false;
  @override
  void initState() {
    super.initState();
    AppApi.firestore
        .collection('users')
        .doc(AppApi.firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      isBabySittingActive = value['isBabySitter'];
    });
  }

  void setBabySitting(bool value) {
    AppApi.firestore
        .collection('users')
        .doc(AppApi.firebaseAuth.currentUser!.uid)
        .update({'isBabySitter': value});

    setState(() {
      isBabySittingActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
      child: isBabySittingActive
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You are currently a baby sitter.'),
                  ElevatedButton(
                      onPressed: () {
                        setBabySitting(false);
                      },
                      child: const Text('cancel your service'))
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setBabySitting(true);
                    },
                    child: const Text('want to become a babysitter')),
                const SizedBox(
                  height: 21.0,
                ),
                const Text('Available baby sitters'),
                Expanded(
                    child: StreamBuilder(
                        stream: AppApi.getActiveBabySitters(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const SizedBox();
                            case ConnectionState.done:
                            case ConnectionState.active:
                              return ListView.builder(
                                itemBuilder: (context, index) => ListTile(
                                  leading: ClipOval(
                                    child: Image.network(
                                      snapshot.data!.docs[index]
                                          .data()['photoUrl'],
                                    ),
                                  ),
                                  title: Text(snapshot.data!.docs[index]
                                      .data()['name']),
                                  subtitle: Text(snapshot.data!.docs[index]
                                      .data()['address']),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      Uri phoneNum = Uri(
                                          scheme: 'tel',
                                          path:
                                              '${snapshot.data!.docs[index].data()['phone']}');
                                      await launchUrl(phoneNum);
                                    },
                                    icon: const Icon(Icons.phone),
                                  ),
                                ),
                                itemCount: snapshot.data!.size,
                              );
                          }
                        }))
              ],
            ),
    );
  }
}
