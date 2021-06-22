import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccination_portal/networking/api.dart';
import 'package:vaccination_portal/networking/formatted_api.dart';
import 'package:vaccination_portal/ui/calender.dart';
import 'package:vaccination_portal/ui/hospital_details.dart';
import 'package:vaccination_portal/ui/sign_up.dart';

import '../random.dart';

class Pincode extends StatefulWidget {
  final String status;

  const Pincode({this.status, Key key}) : super(key: key);

  @override
  _PincodeState createState() => _PincodeState(status);
}

class _PincodeState extends State<Pincode> {
  var _pincode;
  Future vList;
  var date;
  final String vStatus;

  _PincodeState(this.vStatus);

  @override
  void initState() {
    super.initState();


    // TODO: implement initState
    // vList=VaccineData().getdata();
    // vList=VaccineData().getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment for Dose-1"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: FutureBuilder(
        future: vList,
        builder: (context, AsyncSnapshot snapshot) {
          return Padding(
            padding: const EdgeInsets.all(38.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "PinCode",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Enter PinCode",
                          prefixIcon: Icon(FontAwesomeIcons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {
                        setState(() {
                          _pincode = value;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScheduleScreen(
                                        pincode: _pincode,
                                        vStatus: vStatus,
                                      )));
                        });
                      },
                    ),
                  ),
                  //Text("${_pincode}"),
                  Spacer()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

String selectedPincode;

class ScheduleScreen extends StatefulWidget {
  final String pincode;
  final String currentDate;
  final String vStatus;

  const ScheduleScreen({this.vStatus, Key key, this.pincode, this.currentDate})
      : super(key: key);

  @override
  _ScheduleScreenState createState() =>
      _ScheduleScreenState(pincode, currentDate,vStatus);
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  Future<VaccineObject> vlist;
  final String _pincode;
  final String _currentDate;
  final String vStatus;
  Stream<DocumentSnapshot> _doseDoc;

  _ScheduleScreenState(this._pincode, this._currentDate, this.vStatus);

  @override
  // TODO: implement widget
  ScheduleScreen get widget {
    super.widget;
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    selectedPincode = _pincode;

    vlist = getpincode(pincode: _pincode, date: _currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Book Appointment "),
          backgroundColor: Colors.blue.shade900,
          actions: [
            IconButton(
                icon: Icon(FontAwesomeIcons.calendar),
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return Calender();
                    }))
          ],
        ),
        body: FutureBuilder(
          future: vlist,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.sessions.length == 0)
                return Center(
                  child: Text(
                      "No Vaccination Center is available for booking.\nPlease Check Again Later."),
                );
              return ListView.builder(
                itemCount: snapshot.data.sessions.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, int index) {
                  var hospitalName = snapshot.data.sessions[index].name;
                  String hospitalAddress =
                      snapshot.data.sessions[index].address;
                  String block = snapshot.data.sessions[index].blockName;
                  String district = snapshot.data.sessions[index].districtName;
                  String state = snapshot.data.sessions[index].stateName;
                  String vaccine = snapshot.data.sessions[index].vaccine;
                  List<String> slots = snapshot.data.sessions[index].slots;
                  int dose = vStatus == 'Not Vaccinated'
                      ? snapshot.data.sessions[index].availableCapacityDose1
                      : snapshot.data.sessions[index].availableCapacityDose2;

                  if (dose != 0) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.blue,
                      child: InkWell(
                        child: Card(
                          //color: Colors.blue.shade900,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: <Widget>[
                                  Text(
                                    "${hospitalName}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: dose <=10
                                            ? Colors.red
                                            : Colors.green,
                                        fontSize: 16),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    //height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                "${snapshot.data.sessions[index].address}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black))),
                                        Text(
                                            "${snapshot.data.sessions[index].blockName}")
                                        //Text("${snapshot.data.sessions[index].blockName}"),
                                      ],
                                    )),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top :8.0,bottom: 8),
                              //   child: Container(
                              //     height: 0.5, color: Colors.grey,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HospitalDetails(
                                      hospitalName: hospitalName,
                                      hospitalAddress: hospitalAddress,
                                      district: district,
                                      state: state,
                                      slots: slots,
                                      dose1: dose,
                                      block: block,
                                      vaccine: vaccine,
                                  vStatus:vStatus
                                    ))),
                      ),
                    );
                  } else
                    return Container();
                },
              );
            } else if (_pincode == "" || _pincode.length != 6) {
              return Container(
                  child: Center(
                child: Text("Enter Valid Pincode"),
              ));
            } else
              return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Future<VaccineObject> getpincode({String pincode, String date}) =>
      VaccineData().getdata(pincode: pincode, date: date);
}
