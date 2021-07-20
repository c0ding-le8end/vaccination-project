import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccination_portal/ui/verify_email.dart';
import 'package:vaccination_portal/util/global_variables.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password, _gender, _phoneNumber, _age, _aadharNumber;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {

        Navigator.push(context, MaterialPageRoute(builder: (context)=>
VerifyScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          await _auth.currentUser.updateProfile(displayName: _name);
          userDetails = user.user;
          statusIndex=0;
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userDetails.uid)
              .set({
            "details": {
              "name": _name,
              "gender": _gender,
              "phoneNumber": _phoneNumber,
              "age": _age,
              "aadharNumber": _aadharNumber,
              "email":_email
            },
            "Vaccine": {

                "dose1": {"status": "Not Vaccinated", "name": _name,"dose1Date":null,},

                "dose2": {"status": "Not Vaccinated", "name": _name,"dose2Date":null},
                "vaccineType":"Not Selected",


            }
          });
          // await Navigator.pushReplacementNamed(context,"/") ;

        }
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
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async
      {
        await Navigator.pushReplacementNamed(context,"Login") ;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w900,
                  fontSize: 27,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 3)),
          centerTitle: true,
        ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
            child: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(

                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: yellow1,width: 3),
                              borderRadius: BorderRadius.circular(20),//color: yellow1

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextFormField(
                                cursorColor: yellow1,
                                  // ignore: missing_return
                                  validator: (input) {
                                    if (input.isEmpty) return 'Enter Name';
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Name',
                                    labelStyle: TextStyle(color : lightGrey,fontFamily: "OpenSans",fontWeight: FontWeight.bold),


                                    prefixIcon: Icon(Icons.person,color: lightGrey,
                                    ),
                                  ),
                                  onSaved: (input) => _name = input),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: yellow1, width:3),
                              borderRadius: BorderRadius.circular(20),),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextFormField(
                                  cursorColor: yellow1,
                                  // ignore: missing_return
                                  validator: (input) {
                                    if (input.isEmpty) return 'Enter Email';
                                  },
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(color : lightGrey,fontFamily: "OpenSans",fontWeight: FontWeight.bold),
                                      border: InputBorder.none,
                                      labelText: 'Email',
                                      prefixIcon: Icon(Icons.email,color: lightGrey)),
                                  onSaved: (input) => _email = input),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: yellow1,width: 3),
                              borderRadius: BorderRadius.circular(20),//color: yellow1
                            ),

                              child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextFormField(
                                  cursorColor: yellow1,
                                  // ignore: missing_return
                                  validator: (input) {
                                    if (input.length < 6)
                                      return 'Provide Minimum 6 Character';
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color : lightGrey,fontFamily: "OpenSans",fontWeight: FontWeight.bold),
                                    prefixIcon: Icon(Icons.lock,color: lightGrey),
                                  ),
                                  obscureText: true,
                                  onSaved: (input) => _password = input),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: yellow1,width: 3),
                                borderRadius: BorderRadius.circular(20),//color: yellow1
                            ),
                                width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: DropdownButtonFormField<String>(

                                  // ignore: missing_return
                                  validator: (input) {
                                    if (input == null) return 'Enter Gender';
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Gender",
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(color : lightGrey,fontFamily: "OpenSans",fontWeight: FontWeight.bold),

                                      prefixIcon: Icon(FontAwesomeIcons.male,color: lightGrey)),
                                  value: _gender,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Color(0xFF344955)),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _gender = newValue;
                                    });
                                  },
                                  items: <String>['Male', 'Female', 'Other']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: yellow1,width: 3),
                              borderRadius: BorderRadius.circular(20),//color: yellow1
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextFormField(
                                  maxLength: 10,
                                    cursorColor: yellow1,
                                  // ignore: missing_return
                                  validator: (input) {
                                    bool checkSpecial = isSpecial(input);
                                    if (input.isEmpty ||
                                        input.length != 10 ||
                                        checkSpecial) return 'Enter Valid Phone Number';
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    labelText: 'Phone Number',
                                    labelStyle: TextStyle(color : lightGrey,fontFamily: "OpenSans",fontWeight: FontWeight.bold),

                                    prefixIcon: Icon(FontAwesomeIcons.phoneAlt,color: lightGrey),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onSaved: (input) => _phoneNumber = input),
                              ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: yellow1,width: 3),
                              borderRadius: BorderRadius.circular(20),//color: yellow1

                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: TextFormField(
                                  maxLength: 3,
                                  cursorColor: yellow1,
                                  // ignore: missing_return
                                  validator: (input) {
                                    bool checkSpecial = isSpecial(input);
                                    //Parse INT works only inside IF not outside
                                    if (input.isEmpty ||
                                        input.length > 3 ||
                                        checkSpecial ||
                                        int.parse(input) < 18) return 'Enter Valid Age';
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    labelText: 'Age',
                                    prefixIcon: Icon(Icons.people,color: lightGrey,),
                                    labelStyle: TextStyle(color : lightGrey,fontFamily: "OpenSans",fontWeight: FontWeight.bold),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onSaved: (input) => _age = input),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: yellow1,width: 3),
                              borderRadius: BorderRadius.circular(20),//color: yellow1

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextFormField(
                                maxLength: 12,
                                  cursorColor: yellow1,
                                  // ignore: missing_return
                                  validator: (input) {
                                    bool checkSpecial = isSpecial(input);
                                    if (input.isEmpty ||
                                        input.length != 12 ||
                                        checkSpecial)
                                      return 'Enter Valid Aadhar Number';
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(color : lightGrey,fontFamily: "OpenSans",fontWeight: FontWeight.bold),

                                    labelText: 'Aadhar Number',
                                    prefixIcon: Icon(FontAwesomeIcons.fingerprint,color: lightGrey),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onSaved: (input) => _aadharNumber = input),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 15, 70, 15),
                          onPressed: signUp,
                          child: Text('Sign Up',
                              style: TextStyle(
                                  //  color: lightGrey,
                                  fontFamily: "OpenSans",
                                  letterSpacing: 1,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold)),
                          color: yellow1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
          )),
    );
  }

  bool isSpecial(String s) {
    for (int i = 0; i < s.length; i++) {
      if (s[i] == ',' || s[i] == ' ' || s[i] == '.' || s[i] == '-') return true;
    }
    return false;
  }
}


