import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaccination_portal/ui/TestDB.dart';
import 'package:vaccination_portal/ui/loading_screen.dart';
import 'package:vaccination_portal/ui/main%20screen.dart';
import 'package:vaccination_portal/ui/schedule_screen.dart';
import 'package:vaccination_portal/ui/sign_in.dart';
import 'package:vaccination_portal/ui/sign_up.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //final AnonymousAuth _auth=AnonymousAuth();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
          primaryColor: Colors.orange
      ),
      debugShowCheckedModeBanner: false,
      home:

      Sample(),

      routes: <String,WidgetBuilder>{

        "Login" : (BuildContext context)=>Login(),
         "SignUp":(BuildContext context)=>SignUp(),
        // "start":(BuildContext context)=>Start(),
      },

    );
  }

}



