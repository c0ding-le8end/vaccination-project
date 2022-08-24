import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_portal/ui/main screen.dart';
import 'package:vaccination_portal/util/global_variables.dart';

// ignore: must_be_immutable
class HospitalDetails extends StatefulWidget {
  final scheduleDate;
  final String hospitalName;
  final String hospitalAddress;
  final String block;
  final String district;
  final String state;
  final String vaccine;
  final List<dynamic> slots;
  final int dose1;
  final String vStatus;
  final String vType;
  var dose1Date;
   HospitalDetails(
      {Key key,
        this.scheduleDate,
      this.hospitalName,
      this.hospitalAddress,
      this.district,
      this.state,
      this.slots,
      this.dose1,
      this.block,
      this.vaccine,this.vStatus, this.vType, this.dose1Date})
      : super(key: key);

  @override
  _HospitalDetailsState createState() => _HospitalDetailsState(hospitalName,
      hospitalAddress, district, state, slots, dose1, block, vaccine,vStatus,vType,dose1Date,scheduleDate);
}

class _HospitalDetailsState extends State<HospitalDetails> {
  final scheduleDate;
  final String _hospitalName;
  final String _hospitalAddress;
  final String _block;
  final String _district;
  final String _state;
  final String _vaccine;
  final List<dynamic> _slots;
  final int _dose1;
  final String _vStatus;
  final String _vType;
  var _dose1Date;

  _HospitalDetailsState(
      this._hospitalName,
      this._hospitalAddress,
      this._district,
      this._state,
      this._slots,
      this._dose1,
      this._block,
      this._vaccine,
      this._vStatus,
      this._vType, this._dose1Date, this.scheduleDate
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Center"),
        // ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 2),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: Text("$_hospitalName",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                        textAlign: TextAlign.center),
                  ),
                  Divider(
                    thickness: 0.2,
                    color: Colors.black87,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 8),
                    child: Text(
                      "$_hospitalAddress",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15,color: paleGrey),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_block == null ? 'N/A' : "$_block",style: TextStyle(color: paleGrey),),
                      Text("$_district",style: TextStyle(color: paleGrey)),
                      Text("$_state",style: TextStyle(color: paleGrey))
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$_vaccine",
                          style: TextStyle(fontSize: 28),
                        ),
                        Text(
                          "Capacity : $_dose1",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_slots.length, (index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: InkWell(
                                child: Card(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${_slots[index]['time']}",
                                        style: TextStyle(fontSize: 20,color: paleGrey),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Schedule ",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Transform.rotate(
                                              angle: 90 * 3.14 / 180,
                                              child: Icon(
                                                Icons.navigation,
                                                size: 30,
                                                color: yellow1,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ConfirmationScreen(context);
                                      });
                                }),
                          );
                        })),
                  )
                ],
              ),
            )
          ],
        )
        // Center(
        //   child: FlatButton(
        //     child: Text("Schedule"),
        //     onPressed: ()=>ScheduleDate(),
        //   ),
        // ),

        );
  }

  // ignore: non_constant_identifier_names
  ScheduleDate() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userDetails.uid)
        .set({"name": userName, "hospitalName": _hospitalName});
  }

  // ignore: non_constant_identifier_names
  Widget ConfirmationScreen(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm!",style: TextStyle(color: yellow1,)),
      content: Container(
        child: Text("Do you want to Confirm The Slot ?",style: TextStyle(color: darkGrey,fontWeight: FontWeight.bold)),
      ),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel',style: TextStyle(color: lightGrey,))),
        // ignore: deprecated_member_use
        FlatButton(
            onPressed: () async {
              var dose1Status;
              var vaccinationDate= scheduleDate;


              print("$dose1Status");
              if(_vStatus=='Not Vaccinated')
                {debugPrint("$_dose1");
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(userDetails.uid)
                      .update({
                    "Vaccine": {
                      "dose1": {"status": "Partially Vaccinated"},
                      'dose2': {"status": "Under Vaccination"},
                      'vaccineType':_vType,
                      'dose1Date':vaccinationDate,
                      'dose2Date':null
                    }

                });
                      }
              else
                {
                  debugPrint("$_dose1");
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(userDetails.uid)
                    .update({
                "Vaccine": {
                "dose1": {"status": "Fully Vaccinated"},
                'dose2': {"status": "Fully Vaccinated"},
                  'vaccineType':_vType,
                  'dose1Date':_dose1Date,
                  'dose2Date':vaccinationDate
                }
                });

              }
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MainScreen()),
                ModalRoute.withName('MainScreen'),
              );
            },
            child: Text('Ok',style: TextStyle(color: lightGrey,))),
      ],
    );
  }
}
