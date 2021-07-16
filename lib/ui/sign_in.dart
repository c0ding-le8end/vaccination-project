import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:vaccination_portal/ui/forget_password.dart';
import 'package:vaccination_portal/ui/main%20screen.dart';
import 'package:vaccination_portal/ui/sign_up.dart';

import '../main.dart';
//import 'SignUp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var authenticator;
  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);

        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignUp() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                child: Image.asset(
                  "images/Logo.png",
                  width: 250,
                  height: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Email';
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email)),
                              onSaved: (input) => _email = input),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input.length < 6)
                                  return 'Provide Minimum 6 Character';
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                              onSaved: (input) => _password = input),
                        ),
                      ),
                      TextButton(
                        child: Text("Forgot Password?",style:TextStyle(fontSize: 15, color: lightGrey,fontWeight: FontWeight.bold,fontFamily: "OpenSans")),
                        onPressed: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context)
                        {
                         return ResetScreen();
                        })),
                      ),

                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                        onPressed: login,
                        child: Text('Login',
                            style: TextStyle(
                              fontSize: 22.0,
                              // fontWeight: FontWeight.bold
                            )),

                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text('Don\'t have an account ?',
                    style: TextStyle(fontSize: 15, color: lightGrey)),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: TextButton(
                  child: Text('Sign Up',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF344955),
                          fontWeight: FontWeight.bold)),
                  onPressed: navigateToSignUp,
                ),
              ),
            ),
            SizedBox(height: 50,),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: TextButton(
                  child: Text('About Provax',
                      style: TextStyle(fontSize: 15, color: lightGrey)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
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
                        });
                  }),
            ),
          )
          ],
        ),
      ),
    ));
  }
}
