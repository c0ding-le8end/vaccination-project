import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccination_portal/networking/formatted_api.dart';
import 'package:vaccination_portal/ui/about_app.dart';
import 'package:vaccination_portal/util/get_date.dart';
import 'package:vaccination_portal/ui/pincode_choice.dart';
import 'package:vaccination_portal/ui/vaccine_type.dart';
import 'package:vaccination_portal/util/global_variables.dart';
import 'Certificate.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<VaccineObject>? vList;
  bool shouldPop = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isloggedin = false;
  Stream<DocumentSnapshot>? userStream;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("Login");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser!;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser!;

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
    await _auth.signOut();
  }

  @override
  void initState() {
    this.checkAuthentification();
    this.getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  child: Text("SignOut ?",
                      style: TextStyle(
                          color: darkGrey, fontWeight: FontWeight.bold)),
                ),
                actions: [
                  // ignore: deprecated_member_use
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel',
                          style: TextStyle(
                            color: lightGrey,
                          ))),
                  // ignore: deprecated_member_use
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        signOut();
                      },
                      child: Text('Ok',
                          style: TextStyle(
                            color: lightGrey,
                          ))),
                ],
              );
            });
        return false;
      },
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: Text("ProVax",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
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
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: lightGrey, style: BorderStyle.solid)),
                    height: 200,
                    child: DrawerHeader(
                      decoration: BoxDecoration(),
                      child: Container(
                        child: Image.asset(
                          "images/Logo.png",
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
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
                    title: Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.powerOff,
                              color: yellow1,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Logout",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ],
                    ),
                    onTap: signOut,
                  ),
                  ListTile(
                    title:
                        Text("About The App", style: TextStyle(fontSize: 16)),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AboutApp(context).aboutApp();
                          });
                    },
                  ),
                ],
              ),
            ),
            body: StreamBuilder<DocumentSnapshot>(
                stream: userStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.data() != null)
                    return userCard(context, snapshot);
                  else
                    return Center(child: CircularProgressIndicator());
                })
            //Hospital_View(context,snapshot);

            );
      }),
    );
  }

  Container userCard(
      BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    Map<String, dynamic> documentFields =
        snapshot.data!.data() as Map<String, dynamic>;
    var name = documentFields['details']['name'];
    userName = name;
    var phoneNumber = documentFields['details']['phoneNumber'];
    var age = documentFields['details']['age'];
    var aadharNumber = documentFields['details']['aadharNumber'];
    var status = documentFields['Vaccine']['dose1']['status'];
    var dose1Date = documentFields['Vaccine']['dose1Date'];
    var dose2Date = documentFields['Vaccine']['dose2Date'];
    var vaccineType = documentFields['Vaccine']['vaccineType'];
    var gender = documentFields['details']['gender'];
    var doseStyle =
        TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15);
    var vaccinationStatusStyle = TextStyle(color: paleGrey);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 600,
      decoration: BoxDecoration(
          //color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(7)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8),
                child: Text("Account Details",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    )),
              ))
            ],
          ),

          //Card to show Patient Details
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    //Status vaccinated/not
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0)),
                          color: Color(0xFFFBCC84),
                          child: Text(
                            "$status",
                            style: TextStyle(
                              color: darkGrey,
                              //   fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Text(
                          "${vaccineType == 'Not Selected' ? "" : vaccineType}",
                          style: TextStyle(fontSize: 18, color: darkGrey),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      //Name
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("${name[0].toUpperCase()}${name.substring(1)}",
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
                            color: lightGrey,
                          )
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
                            style: TextStyle(fontSize: 17, color: paleGrey),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                            child: Text(
                          "Mobile Number: $phoneNumber",
                          style: TextStyle(
                            fontSize: 17,
                            color: paleGrey,
                          ),
                        ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Aadhaar ID: ${aadharNumber.substring(0, 4)}-${aadharNumber.substring(4, 8)}-${aadharNumber.substring(8, 12)}",
                          style: TextStyle(fontSize: 17, color: paleGrey),
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
                                style: doseStyle,
                              ),
                            ),
                            //Schedule Button-Navigates to Scheduling screen
                            Padding(
                              padding: const EdgeInsets.only(left: 160.0),
                              // ignore: deprecated_member_use
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 8,
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                                onPressed: status == 'Not Vaccinated'
                                    ? () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VaccineType(
                                                      status: status,
                                                      dose1Date: dose1Date,
                                                    )));
                                      }
                                    : null,
                                child: Text(
                                    status == 'Not Vaccinated'
                                        ? "Schedule"
                                        : "Scheduled",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: darkGrey)),
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 3),
                      child: Text(
                        dose1Date == null
                            ? ""
                            : (DateGet.getCurrentDate()
                                        .compareTo(dose1Date.toString()) >=
                                    0
                                ? "Vaccinated on $dose1Date"
                                : "      Vaccination Scheduled on $dose1Date"),
                        style: vaccinationStatusStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
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
                                style: doseStyle,
                              ),
                            ),

                            //Schedule Button-Navigates to Scheduling screen
                            Padding(
                              padding: const EdgeInsets.only(left: 160.0),
                              // ignore: deprecated_member_use
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 8,
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                                // disabledColor: paleGrey,
                                onPressed: documentFields['Vaccine']['dose2']
                                                ['status'] ==
                                            'Not Vaccinated' ||
                                        documentFields['Vaccine']['dose2']
                                                ['status'] ==
                                            'Fully Vaccinated'
                                    ? null
                                    : () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Pincode(
                                                    vaccineType: vaccineType,
                                                    dose1Date: dose1Date)));
                                      },
                                child: Text(
                                    documentFields['Vaccine']['dose2']
                                                ['status'] ==
                                            'Fully Vaccinated'
                                        ? "Scheduled"
                                        : "Schedule",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: darkGrey
                                        //    color: Colors.white),
                                        )),
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 3),
                      child: Text(
                        dose2Date == null
                            ? ""
                            : (DateGet.getCurrentDate()
                                        .compareTo(dose2Date.toString()) >=
                                    0
                                ? "Vaccinated on $dose2Date,"
                                : "      Vaccination Scheduled on $dose2Date"),
                        style: vaccinationStatusStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      // ignore: deprecated_member_use
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: Colors.transparent,
                          backgroundColor: yellow1,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                        ),
                        onPressed: documentFields['Vaccine']['dose2']
                                    ['status'] !=
                                'Fully Vaccinated'
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Certificate(
                                            name: name,
                                            phoneNumber: phoneNumber,
                                            age: age,
                                            aadharNumber: aadharNumber,
                                            gender: gender,
                                            vaccineType: vaccineType)));
                              },
                        child: documentFields['Vaccine']['dose2']['status'] !=
                                'Fully Vaccinated'
                            ? Container()
                            : Text("Certificate",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black
                                  //    color: Colors.white),
                                )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
