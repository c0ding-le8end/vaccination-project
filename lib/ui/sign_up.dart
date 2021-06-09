import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

User userDetails;
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password, _gender, _phoneNumber,_age,_aadharNumber;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
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
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser.updateProfile(displayName: _name);
          userDetails = user.user;
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userDetails.uid)
              .set({"name": _name,"gender":_gender,"phoneNumber":_phoneNumber,"age":_age,"aadharNumber":_aadharNumber});
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
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Name';
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (input) => _name = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Email';
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)),
                          onSaved: (input) => _email = input),
                    ),
                    Container(
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
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonFormField<String>(
                          validator: (input) {
                            if (input==null) return 'Enter Gender';
                          },
                          decoration: InputDecoration(
                              labelText: "Gender",
                              prefixIcon: Icon(FontAwesomeIcons.male)),
                          value: _gender,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _gender = newValue;
                            });
                          },
                          items: <String>[
                            'Male',
                            'Female',
                            'Other'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            bool checkSpecial=isSpecial(input);
                            if (input.isEmpty||input.length!=10||checkSpecial) return 'Enter Valid Phone Number';
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(FontAwesomeIcons.phoneAlt),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (input) => _phoneNumber = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            bool checkSpecial=isSpecial(input);
                            //Parse INT works only inside IF not outside
                            if (input.isEmpty||input.length>3||checkSpecial||int.parse(input)<18) return 'Enter Valid Age';
                          },
                          decoration: InputDecoration(
                            labelText: 'Age',
                            prefixIcon: Icon(FontAwesomeIcons.phoneAlt),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (input) => _age = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            bool checkSpecial=isSpecial(input);
                            if(input.isEmpty||input.length!=12||checkSpecial) return 'Enter Valid Aadhar Number';
                          },
                          decoration: InputDecoration(
                            labelText: 'Aadhar Number',
                            prefixIcon: Icon(FontAwesomeIcons.fingerprint),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (input) =>  _aadharNumber = input),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: signUp,
                      child: Text('SignUp',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      color: Colors.orange,
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
    ));
  }
  bool isSpecial(String s) {
      for (int i = 0; i < s.length; i++) {
        if (s[i] == ',' || s[i] == ' ' || s[i] == '.' || s[i] == '-')
          return true;
      }
    return false;
  }
}


// validator: (val) =>
// val.length < 6 ?
// 'Still too short' : null
