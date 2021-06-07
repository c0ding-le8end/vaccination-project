import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_portal/ui/sign_up.dart';
import 'package:vaccination_portal/ui/main screen.dart';
class HospitalDetails extends StatefulWidget {
  final String hospitalName;

  const HospitalDetails({Key key, this.hospitalName}) : super(key: key);


  @override
  _HospitalDetailsState createState() => _HospitalDetailsState(hospitalName);
}

class _HospitalDetailsState extends State<HospitalDetails> {
  final String _hospitalName;

  _HospitalDetailsState(this._hospitalName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text("Schedule"),
          onPressed: ()=>ScheduleDate(),
        ),
      ),


    );
  }

  ScheduleDate() async{
    await FirebaseFirestore.instance.collection("users").doc(userDetails.uid).set({"name":userName,"hospitalName":_hospitalName});
  }

}
