import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccination_portal/networking/api.dart';

import 'package:vaccination_portal/networking/formatted_api.dart';
import 'package:vaccination_portal/ui/schedule_screen.dart';
import 'package:vaccination_portal/ui/vaccine_type.dart';

import 'sign_up.dart';

String userName;
int statusIndex = 0;

class Sample extends StatefulWidget {
  const Sample({
    Key key,
  }) : super(key: key);

  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  Future<VaccineObject> vList;

  // String _pincode="560078";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  Stream<DocumentSnapshot> userStream;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("Login");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        userDetails = firebaseUser;
        this.isloggedin = true;
        userStream = FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseUser.uid)
            .snapshots();
        if (userStream == null) {
          setState(() {
            userStream = FirebaseFirestore.instance
                .collection("users")
                .doc(firebaseUser.uid)
                .snapshots();
          });
        }
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    // vList = VaccineData().getdata(pincode:_pincode);
    this.checkAuthentification();
    this.getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ProVax",
              style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w900,
                  fontSize: 27,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 3)),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 70,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFF344955)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Drawer Header",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text("Profile", style: TextStyle(fontSize: 16)),
                onTap: () => debugPrint("Test1"),
              ),
              // ListTile(
              //   title: Text("Vaccine Info",style: TextStyle(
              //       fontSize: 16,
              //       color: Colors.white
              //   )),
              //   onTap: ()=>debugPrint("Test1"),
              //   tileColor: Colors.blue.shade900,
              // ),
              // ListTile(
              //   title: Text("FAQ",style: TextStyle(
              //       fontSize: 16,
              //       color: Colors.white
              //   )),
              //   onTap: ()=>debugPrint("Test1"),
              //   tileColor: Colors.blue.shade900,
              // ),
              ListTile(
                title: Text("Logout",
                    style: TextStyle(
                      fontSize: 16,
                    )),
                onTap: signOut,
              )
            ],
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: userStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data() != null)
                return userCard(context, snapshot);
              else
                return Center(child: CircularProgressIndicator());
            })
        //Hospital_View(context,snapshot);

        );
  }

  Container userCard(
      BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    Map<String, dynamic> documentFields = snapshot.data.data();
    var name = documentFields['details']['name'];
    userName = name;
    var phoneNumber = documentFields['details']['phoneNumber'];
    var age = documentFields['details']['age'];
    var aadharNumber = documentFields['details']['aadharNumber'];
    var status = documentFields['Vaccine']['dose1']['status'];
    var vaccineType = documentFields['Vaccine']['vaccineType'];
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 550,
      decoration: BoxDecoration(
          //color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(7)),
      child: Card(
        //color: Colors.blue.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Account Details",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      )),
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Registered Mobile Number: $phoneNumber",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
              ],
            ),
            //Card to show Patient Details
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.black),
                child: Card(
                  //color: Colors.blue.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        //Status vaccinated/not
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${status}",
                              style: TextStyle(
                                backgroundColor: Colors.amberAccent.shade200,
                                //   fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          //Name
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("$name ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  )),
                              Icon(
                                  documentFields['details']['gender'] == 'Male'
                                      ? FontAwesomeIcons.male
                                      : (documentFields['details']['gender'] ==
                                              'Other'
                                          ? FontAwesomeIcons.transgender
                                          : FontAwesomeIcons.female),
                                  color: documentFields['details']['gender'] ==
                                          'Male'
                                      ? Colors.blue.shade900
                                      : Colors.pinkAccent)
                            ],
                          ),
                        ),
                        //REF ID and Secret Code
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: <Widget>[
                        //     Text("REF ID : 92188649098090 ",style: TextStyle(
                        //         fontSize: 16
                        //     ),),
                        //     Text("| Secret Code : 8090",style: TextStyle(
                        //         fontSize: 16
                        //     ),)
                        //   ],
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          //Year of Birth Photo ID: Aadhaar Card  ID Number:
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Age: $age ",
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Aadhaar Card  ID Number:$aadharNumber",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        //Horizontal Line
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            //Booking window
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.syringe,
                                  size: 25,
                                  color: Colors.red,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Dose 1",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                //Schedule Button-Navigates to Scheduling screen
                                Padding(
                                  padding: const EdgeInsets.only(left: 160.0),
                                  child: RaisedButton(
                                    onPressed: status == 'Not Vaccinated'
                                        ? () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VaccineType(
                                                          status: status,
                                                        )));
                                          }
                                        : null,
                                    child: Text(
                                        status == 'Not Vaccinated'
                                            ? "Schedule"
                                            : "Scheduled",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          //  color: Colors.white),
                                        )),
                                    shape: ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                  ),
                                ),
                              ],
                            )),
                        //Appointment Status
                        // Padding(
                        //   padding: const EdgeInsets.only(left:15),
                        //   child: Row(
                        //     children: <Widget>[
                        //       Text("Appointment not scheduled",style: TextStyle(
                        //           color: Colors.red,
                        //           fontSize: 16
                        //       ),)
                        //     ],
                        //   ),
                        // ),
                        //Dose 2 Schedule
                        Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            //Booking window
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.syringe,
                                  size: 25,
                                  color: Colors.red,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Dose 2",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                //Schedule Button-Navigates to Scheduling screen
                                Padding(
                                  padding: const EdgeInsets.only(left: 160.0),
                                  child: RaisedButton(
                                    onPressed: documentFields['Vaccine']
                                                    ['dose2']['status'] ==
                                                'Not Vaccinated' ||
                                            documentFields['Vaccine']['dose2']
                                                    ['status'] ==
                                                'Fully Vaccinated'
                                        ? null
                                        : () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Pincode(
                                                          vaccineType:
                                                              vaccineType,
                                                        )));
                                          },
                                    child: Text(
                                        documentFields['Vaccine']['dose2']
                                                    ['status'] ==
                                                'Fully Vaccinated'
                                            ? "Scheduled"
                                            : "Schedule",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          //    color: Colors.white),
                                        )),
                                    shape: ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// onPressed: () => {
// Navigator.push(context, MaterialPageRoute(builder: (context)=>Pincode()))

// Widget Hospital_View(context,snapshot)
// {
//   return ListView.builder(
// //     itemCount: snapshot.data.sessions.length,
// //     scrollDirection:Axis.vertical,
//     itemBuilder: (context,int index)
//     {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.blueGrey.shade900
//               ),
//               width: MediaQuery.of(context).size.width,
//               height: 100,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text("${snapshot.data.sessions[index].name}",
//                   style: TextStyle(
//                       color: Colors.white
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     }
//     ,);
// }
