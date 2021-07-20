import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_portal/ui/pincode_choice.dart';


class VaccineType extends StatefulWidget {
  final String status;
  final dose1Date;

  const VaccineType({Key key, this.status,this.dose1Date}) : super(key: key);

  @override
  _VaccineTypeState createState() => _VaccineTypeState(status,dose1Date);
}

class _VaccineTypeState extends State<VaccineType> {
  final String _vStatus;
final _dose1Date;
  _VaccineTypeState(this._vStatus,this._dose1Date);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Vaccine Type",style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w900,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              letterSpacing: 2)),
          centerTitle: false,),

         // backgroundColor: Colors.blue.shade900,
        body: Container(
            child: Padding(
                padding: const EdgeInsets.all(38.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Choose Vaccine Type",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Pincode(
                                            status: _vStatus,
                                            vaccineType: "COVISHIELD",dose1Date:_dose1Date)));
                              },
                              child: Text("COVISHIELD"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Pincode(
                                            status: _vStatus,
                                            vaccineType: "COVAXIN",dose1Date:_dose1Date)));
                              },
                              child: Text("COVAXIN"),
                            ),
                          ),
                        ])))));
  }
}
