import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccination_portal/util/get_date.dart';
import 'package:vaccination_portal/ui/Certificate.dart';
import 'package:vaccination_portal/ui/pincode_choice.dart';
import 'package:vaccination_portal/ui/vaccine_type.dart';
import 'package:vaccination_portal/util/global_variables.dart';



class UserCard
{
  Container userCard(
      BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    Map<String, dynamic> documentFields = snapshot.data!.data() as Map<String, dynamic>;
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
                    padding: const EdgeInsets.only(top:8.0,left: 8),
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
                        Text("${vaccineType=='Not Selected'?"":vaccineType}",style: TextStyle(fontSize: 18,color: darkGrey),)
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
                              color:
                              documentFields['details']['gender'] == 'Male'
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
                            style: TextStyle(fontSize: 17,color: paleGrey),
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
                                fontSize: 17,color: paleGrey,
                              ),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Aadhaar ID: $aadharNumber",
                          style: TextStyle(fontSize: 17,color: paleGrey),
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
                              // ignore: deprecated_member_use
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(elevation: 8,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),backgroundColor: yellow1),
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
                                        fontSize: 14,color: darkGrey

                                    )),
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width /3),
                      child: Text(dose1Date == null
                          ? ""
                          : (DateGet.getCurrentDate().compareTo(dose1Date.toString())>=0
                          ? "Vaccinated on $dose1Date"
                          : "Vaccination Scheduled on $dose1Date"),style: TextStyle(color: paleGrey),),
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
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),

                            //Schedule Button-Navigates to Scheduling screen
                            Padding(
                              padding: const EdgeInsets.only(left: 160.0),
                              // ignore: deprecated_member_use
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(elevation: 8,
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),),
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
                      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width /3),
                      child: Text(dose2Date == null
                          ? ""
                          : (DateGet.getCurrentDate().compareTo(dose2Date.toString())>=0
                          ? "Vaccinated on $dose2Date,"
                          : "Vaccination Scheduled on $dose2Date"),style: TextStyle(color: paleGrey),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      // ignore: deprecated_member_use
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(disabledBackgroundColor: Colors.transparent,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),),
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
