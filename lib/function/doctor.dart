import 'package:baby_care/screens/doctor_page.dart';
import 'package:flutter/material.dart';

import '../Api/api.dart';
import '../model/doctor_model.dart';

class doctor extends StatefulWidget {
  const doctor({super.key});

  @override
  State<doctor> createState() => _doctorState();
}

class _doctorState extends State<doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Handle search text changes
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream:  AppApi.getDoctors(),
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
                      return ListView.builder(
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) => _doctorWidget(
                          DoctorModel.fromJson( snapshot.data!.docs[index].data())
                        ));
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
  Widget _doctorWidget(DoctorModel doctorModel){
    return ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorPage(doctorModel: doctorModel),));
      },
      leading: ClipOval(
          child: Image.network(
            doctorModel.image,
            width: 40.0,
            height: 40.0,
          )),
      title: Text(doctorModel.name),
      subtitle: Text(doctorModel.hospital),
      trailing: const Icon(Icons.arrow_forward),
    );
  }
}