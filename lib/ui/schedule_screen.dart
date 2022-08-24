import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccination_portal/networking/api.dart';
import 'package:vaccination_portal/networking/formatted_api.dart';
import 'package:vaccination_portal/ui/calender.dart';
import 'package:vaccination_portal/ui/hospital_details.dart';
import 'package:vaccination_portal/util/global_variables.dart';








class ScheduleScreen extends StatefulWidget {
  final String pincode;
  final String currentDate;
  final String vStatus;
  final String vaccineType;
  final int todayDate;
  final dose1Date;

  const ScheduleScreen(
      {this.vStatus,
      Key key,
      this.pincode,
      this.currentDate,
      this.vaccineType,
      this.todayDate,
      this.dose1Date})
      : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState(
      pincode, currentDate, vStatus, vaccineType, todayDate, dose1Date);
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  Future<VaccineObject> vlist;
  final String _pincode;
  final  String _currentDate;
  final String vStatus;
  final String _vaccineType;
  final int _todayDate;
  final _dose1Date;


  _ScheduleScreenState(this._pincode, this._currentDate, this.vStatus,
      this._vaccineType, this._todayDate, this._dose1Date);

  @override
  // TODO: implement widget
  // ignore: missing_return
  ScheduleScreen get widget {
    super.widget;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedPincode = _pincode;

    vlist = getpincode(pincode: _pincode, date: _currentDate);
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    int j = 0;
    int containerCount = 0;

    return Scaffold(
        appBar: AppBar(
          title: Text("Vaccination Centres",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 1)),
          centerTitle: false,
          actions: [
            IconButton(
                icon: Icon(FontAwesomeIcons.calendar),
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return Calender(
                        vaccineType: _vaccineType,
                        todayDate: _todayDate,
                        dose1Date: _dose1Date,
                        vStatus: vStatus,
                      );
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
              List.generate(snapshot.data.sessions.length, (index) {
                int dose = vStatus == 'Not Vaccinated'
                    ? snapshot.data.sessions[index].availableCapacityDose1
                    : snapshot.data.sessions[index].availableCapacityDose2;
                String vType = snapshot.data.sessions[index].vaccine;
                if (dose != 0 && vType == _vaccineType) return containerCount++;
              });
              print("$containerCount is here");
              if (containerCount == 0)
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
                  List<dynamic> slots = snapshot.data.sessions[index].slots;
                  int dose = vStatus == 'Not Vaccinated'
                      ? snapshot.data.sessions[index].availableCapacityDose1
                      : snapshot.data.sessions[index].availableCapacityDose2;
                  String feeType = snapshot.data.sessions[index].feeType;
                  String fee = snapshot.data.sessions[index].fee;
                  String vType = snapshot.data.sessions[index].vaccine;
                  debugPrint(
                      "${vType == "COVISHIELD" ? i++ : "Covaxin:${j++}"}");
                  if (dose != 0 && vType == _vaccineType) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                        child: Card(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "$hospitalName",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,

                                            fontSize: 16),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Doses Available: $dose",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: dose <= 10
                                              ? Colors.red
                                              : Colors.green,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical:8.0),
                                child: Container(
                                  //height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                "${snapshot.data.sessions[index].address}",
                                                style: TextStyle(color: paleGrey,
                                                  fontWeight:
                                                  FontWeight.bold,))),
                                        Text(
                                            "${snapshot.data.sessions[index].blockName}")
                                      ],
                                    )),
                              ), Divider(thickness: 1.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Text(
                                            feeType=="Paid"?"Cost: ₹$fee":"Free",
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                color: lightGrey))),
                                  ],

                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HospitalDetails(
                                  scheduleDate:chosenDate,
                                  hospitalName: hospitalName,
                                  hospitalAddress: hospitalAddress,
                                  district: district,
                                  state: state,
                                  slots: slots,
                                  dose1: dose,
                                  block: block,
                                  vaccine: vaccine,
                                  vStatus:vStatus,
                                  vType: _vaccineType,
                                    dose1Date:_dose1Date
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
