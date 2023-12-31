import 'dart:convert';

import 'package:baby_care/screens/doctor_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api/api.dart';
import '../model/doctor_model.dart';

class doctor extends StatefulWidget {
  const doctor({super.key});

  @override
  State<doctor> createState() => _doctorState();
}

class _doctorState extends State<doctor> {
  final _searchController = TextEditingController();
  List<DocumentSnapshot> documents = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(_searchValue);
  }

  void _searchValue() {
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,

              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),

            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: AppApi.getDoctors(),
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

                      documents = snapshot.data!.docs;
                      //todo Documents list added to filterTitle
                      if (_searchController.text.isNotEmpty) {
                        documents = documents.where((element) {
                          return element
                              .get('name')
                              .toString()
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase());
                        }).toList();
                      }


                      return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            return _doctorWidget(DoctorModel.fromRawJson(
                                jsonEncode(documents[index].data())));
                          });
                    } else {
                      return const Center(
                        child: Text('No doctor found!'),
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

  Widget _doctorWidget(DoctorModel doctorModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13.0, vertical: 4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(0xFFFF4891))),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DoctorPage(doctorModel: doctorModel),
          ));
        },
        leading: ClipOval(
            child: Image.network(
          doctorModel.image,
          width: 40.0,
          height: 40.0,
        )),
        title: Text(doctorModel.name),
        subtitle: Text(doctorModel.hospital),
        trailing: IconButton(
            onPressed: () async {
              Uri phoneno = Uri(scheme: 'tel', path: '${doctorModel.phone}');
              await launchUrl(phoneno);
            },
            icon: const Icon(
              Icons.call,
              color: Color(0xFFFF4891),
            )),
      ),
    );
  }
}
