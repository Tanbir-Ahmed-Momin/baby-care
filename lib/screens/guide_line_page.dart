import 'package:baby_care/model/guideLine_model.dart';
import 'package:flutter/material.dart';

class GuideLinePage extends StatelessWidget {
  final GuideLineModel model;
  const GuideLinePage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4891),
      ),
      body: Padding(padding: EdgeInsets.all(13.0),
      child: ListView(
        children: [
          Text(model.title,style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 16.0,),
          Text(model.details,
            textAlign: TextAlign.justify,
          )
        ],
      ),
      ),
    );
  }
}
