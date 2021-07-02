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



Color lightGrey=Color(0xFF344955);
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

      theme: appTheme(
      ),
      debugShowCheckedModeBanner: false,
      home:

      Sample(),

      routes: <String,WidgetBuilder>{

        "Login" : (BuildContext context)=>Login(),
         "SignUp":(BuildContext context)=>SignUp(),
         "MainScreen":(BuildContext context)=>Sample(),
      },

    );
  }

  ThemeData appTheme() {
  //  return   ThemeData(
    //
    //scaffoldBackgroundColor: Color(0xFF344955),
    final ThemeData base = ThemeData.light();
    return base.copyWith(//brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFF3F3F3),
      //  backgroundColor: Color(0xFFF344955),
        primaryColor: Color(0xFF344955),
       buttonTheme: ButtonThemeData(buttonColor: Color(0xFFF9AA33),), //Color(0xFF344955)  //F9AA33
        textTheme:getTextTheme(base.textTheme)
// buttontext 232F34

    );




    }
  TextTheme getTextTheme(TextTheme base)
  {
    return base.copyWith(
       title: base.title.copyWith(color: Colors.blue),
      //  subtitle: base.subtitle1.copyWith(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.red),
       body1: base.body1.copyWith(fontWeight: FontWeight.bold,color: Color(0xFF232F34),fontFamily:"WorkSans",),
      // body2: base.body2.copyWith(fontWeight: FontWeight.bold,color: Colors.pink,fontFamily:"Lobster"),
        button: base.button.copyWith(letterSpacing: 1,color: Color(0xFF232F34))
    );}

}



