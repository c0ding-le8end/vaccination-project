
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';


class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email;
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
var emailException;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password'),centerTitle: true,),
      body: Form(key: _emailKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: yellow1, width:3),
                  borderRadius: BorderRadius.circular(20),),
                child: TextFormField(validator: (value) {
                  if (value.isEmpty) return 'Enter Email';

                },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color : lightGrey,fontFamily: "OpenSans",fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email,color: lightGrey)),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Send Request'),
                onPressed: () async{

                 if(_emailKey.currentState.validate()) {
                   try {
                    await auth.sendPasswordResetEmail(email: _email);

                     showDialog(context: context, builder: (context) {
                       return AlertDialog(

                         content: Text(
                             "A link has been sent to your email to reset the password."),
                         actions: <Widget>[
                           FlatButton(
                               onPressed: () {
                                 Navigator.of(context).pop();
                                 Navigator.of(context).pop();
                               },
                               child: Text('OK'))
                         ],
                       );
                     });

                   }
                  catch
                  (e)
                  {
                    showError(e.message);

                  }

                }
                },


              ),
            ),

          ],),
      ),
    );
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
}