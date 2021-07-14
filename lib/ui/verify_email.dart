import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_portal/ui/main%20screen.dart';


class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer,verifier;
  int stopClock=60;
  @override
  void initState() {

    user = auth.currentUser;
    user.sendEmailVerification();

    verifier = Timer.periodic(Duration(seconds: 1), (verifier) {
setState(() {
  stopClock--;
});
      checkEmailVerified();
    });

    timer=Timer(Duration(seconds: 60),() async{
      await user.delete();
      FirebaseFirestore.instance.collection("users").doc(user.uid).delete();
      Navigator.pop(context);
    });

    super.initState();
  }

  @override
  void dispose() {
    verifier.cancel();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async
      {await user.delete();
        FirebaseFirestore.instance.collection("users").doc(user.uid).delete();
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                  'An email has been sent to ${user.email} please verify'),
            ),
            RaisedButton(
              onPressed: () {
                print(user.sendEmailVerification());
              },
              child: Text(
                  "Resend Email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    //    color: Colors.white),
                  )),
              shape: ContinuousRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(18)),
            ),
              Text("$stopClock",style: TextStyle
              (fontSize: 20,fontWeight: FontWeight.bold,),)

          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      verifier.cancel();
      timer.cancel();
      Navigator.pushReplacementNamed(context, "/");
    }
  }

}