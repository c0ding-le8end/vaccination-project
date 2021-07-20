
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AboutApp
{
  BuildContext context;
  AboutApp(this.context);
  Widget aboutApp()
  {
    return BackdropFilter(
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("About App",
            style: TextStyle(fontWeight: FontWeight.bold),),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(flex: 1,
                  child: SingleChildScrollView(
                    child: Text(
                      "’Provax’’ is an android application used to help in scheduling slots for covid-19 vaccination. The purpose of this application is to keep a track of those to be administered the doses and prevent malpractices. Thereby efficiently carrying out the vaccination drive.It provides an easy and fast way for checking available vaccine slots for any given pincode and lets users book a slot. Here users can easily find the details of vaccination centres through their mobiles. Users need to register with the application using their Aadhar card number and mobile number to start booking. Users can get details about the hospital/vaccination centre like its location, type of vaccines available and number of doses available. This system enables users to schedule a slot in the next seven days. Once the user has scheduled for the first dose the application allows the user to book the second dose after the specified amount of time based on the type of vaccine.",
                      style: TextStyle(color: Colors.white,fontFamily: "WorkSans"),

                    ),
                  ),
                ),
// ignore: deprecated_member_use
                RaisedButton(
                    child: Text("Ok"),shape: ContinuousRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18)
                ),
                    onPressed: () {
                      Navigator.pop(context);
                    }

                )
              ],
            ),
          ),

        ),
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6));
  }

}



