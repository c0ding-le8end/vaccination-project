import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccination_portal/ui/sign_up.dart';
import 'package:vaccination_portal/ui/main screen.dart';
class HospitalDetails extends StatefulWidget {
  final String hospitalName;
  final String hospitalAddress;
  final String block;
  final String district;
  final String state;
  final String vaccine;
  final List<String> slots;
  final int dose1;
  const HospitalDetails({Key key, this.hospitalName, this.hospitalAddress, this.district, this.state, this.slots, this.dose1, this.block, this.vaccine}) : super(key: key);


  @override
  _HospitalDetailsState createState() => _HospitalDetailsState(hospitalName,hospitalAddress,district,state,slots,dose1,block,vaccine);
}

class _HospitalDetailsState extends State<HospitalDetails> {
  final String _hospitalName;
  final String _hospitalAddress;
  final String _block;
  final String _district;
  final String _state;
  final String _vaccine;
  final List<String> _slots;
  final int _dose1;
  _HospitalDetailsState(this._hospitalName, this._hospitalAddress, this._district, this._state, this._slots, this._dose1, this._block, this._vaccine);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Center"),
      ),
      body:
        ListView(
          children:[
            Container(
              margin: EdgeInsets.only(bottom: 2),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 20),
                    child: Text("${_hospitalName}",style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                    ),
                        textAlign: TextAlign.center),
                  ),
                  Divider(
                    thickness: 0.2,
                    color: Colors.black87,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:5.0,horizontal: 8),
                    child: Text("${_hospitalAddress}",textAlign:  TextAlign.center,style: TextStyle(
                      fontSize: 15
                    ),),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_block==null?'N/A':"${_block}"),
                      Text("${_district}"),
                      Text("${_state}")
                    ],
                  ),
                  Divider(
                    thickness: 0.2,
                    color: Colors.black87,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${_vaccine}",style: TextStyle(
                          fontSize: 28
                        ),),
                        Text("Capacity : ${_dose1}",style: TextStyle(
                          fontSize: 20
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                        List.generate(_slots.length,(index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal:18.0),
                            child: InkWell(
                              child: Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${_slots[index]}",style: TextStyle(
                                      fontSize: 20
                                    ),),
                                    Row(
                                      children: [
                                        Text("Schedule ",style: TextStyle(
                                          fontSize: 20,
                                        ),),
                                        Transform.rotate(
                                            angle: 90 * 3.14 / 180,
                                            child: Icon(Icons.navigation,size: 30,))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                showDialog(context: context, builder: (context) {
                                  return ConfirmationScreen(context);
                                });
                              }
                            ),
                          );
                        })

                    ),
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

  ScheduleDate() async{
    await FirebaseFirestore.instance.collection("users").doc(userDetails.uid).set({"name":userName,"hospitalName":_hospitalName});
  }

}

Widget ConfirmationScreen(BuildContext context)
{
  return AlertDialog(
    title: Text("Confirm!"),
    content: Container(
      child: Text("Confirm Slot"),
    ),
    actions: [
      FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel')),
      FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Ok')),
    ],
  );
}
