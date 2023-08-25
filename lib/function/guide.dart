import 'dart:convert';

import 'package:baby_care/model/guideLine_model.dart';
import 'package:baby_care/screens/guide_line_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Api/api.dart';

class guide extends StatefulWidget {



  const guide({super.key});

  @override
  State<guide> createState() => _guideState();
}

class _guideState extends State<guide> {

  final _searchController = TextEditingController();
  List<DocumentSnapshot> documents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {

                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream:  AppApi.getGuideLines(),
              builder:(context, snapshot) {
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
                          print(element.id);
                          return element
                              .get('title')
                              .toString()
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase());
                        }).toList();
                      }

                      return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index){
                            return _guideLineWidget(
                                GuideLineModel.fromRawJson(jsonEncode(documents[index].data()))
                            );
                          });
                    } else {
                      return const Center(
                        child: Text('No guideline found!'),
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

  Widget _guideLineWidget(GuideLineModel model){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13.0,vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color:  Color(0xFFFF4891)
        )
      ),
      child: ListTile(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => GuideLinePage(model: model),));
        },
        leading: const Icon(Icons.tips_and_updates,color:  Color(0xFFFF4891),),
        title: Text(model.title),
        trailing: const Icon(Icons.arrow_forward,
        color:  Color(0xFFFF4891),
        ),
      ),
    );
  }
}