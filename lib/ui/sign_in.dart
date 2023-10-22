import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccination_portal/ui/about_app.dart';
import 'package:vaccination_portal/ui/forget_password.dart';
import 'package:vaccination_portal/ui/sign_up.dart';
import 'package:vaccination_portal/util/global_variables.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var authenticator;
  String? _email, _password;

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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email!, password: _password!);
      } on FirebaseAuthException catch (e) {
        showError(e.message.toString());
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
              // ignore: deprecated_member_use
              ElevatedButton(
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
                          child: TextFormField(cursorColor: yellow1,
                              // ignore: missing_return
                              validator: (input) {
                                if (input!.isEmpty) return 'Enter Email';
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email',labelStyle: TextStyle(color : lightGrey,fontFamily: "OpenSans",fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(Icons.email,color: lightGrey,)),
                              onSaved: (input) => _email = input),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          child: TextFormField(cursorColor: yellow1,
                              // ignore: missing_return
                              validator: (input) {
                                if (input!.length < 6)
                                  return 'Provide Minimum 6 Character';
                              },
                              decoration: InputDecoration(enabled: true,

                                labelText: 'Password',labelStyle: TextStyle(color : lightGrey,fontFamily: "OpenSans",fontWeight: FontWeight.bold),
                                prefixIcon: Icon(Icons.lock,color: lightGrey,),
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

                      // ignore: deprecated_member_use
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(padding: EdgeInsets.fromLTRB(70, 10, 70, 10),backgroundColor: yellow1),
                        onPressed: login,
                        child: Text('Login',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black
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
                    style: TextStyle(fontSize: 15, color: lightGrey,fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: TextButton(
                  child: Text('Sign Up',
                      style: TextStyle(
                          fontSize: 18,
                          color: darkGrey,
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
                          return AboutApp(context).aboutApp();
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
