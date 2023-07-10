import 'package:baby_care/model/doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatelessWidget {
  static const String doctorPageRoute = "/doctorPage";
  final DoctorModel doctorModel;
  const DoctorPage({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4891),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.0,vertical: 10.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(doctorModel.image,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 8.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(doctorModel.name,style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 8.0,),
                      Text('Hospital: ${doctorModel.hospital}'),
                      SizedBox(height: 8.0,),
                      Text('Number: ${doctorModel.phone}'),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0,),
            Text('Degrees:'),
            SizedBox(height: 8.0,),
            Text(doctorModel.degrees,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
            ),
            SizedBox(height: 12.0,),
            Text(doctorModel.details,
              textAlign: TextAlign.justify,
              style: TextStyle(
              fontSize: 16.0,
            ),
            )
          ],
        ),
      ),
    );
  }
}
