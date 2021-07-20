
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_portal/ui/main%20screen.dart';
import 'package:vaccination_portal/ui/sign_in.dart';
import 'package:vaccination_portal/ui/sign_up.dart';
import 'package:vaccination_portal/util/global_variables.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //final AnonymousAuth _auth=AnonymousAuth();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "MainScreen": (BuildContext context) => MainScreen(),
      },
    );
  }

  ThemeData appTheme() {
    //  return   ThemeData(
    //
    //scaffoldBackgroundColor: Color(0xFF344955),
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      //brightness: Brightness.light,
      scaffoldBackgroundColor: Color(0xFFF3F3F3),
      //  backgroundColor: Color(0xFFF344955),
      primaryColor: Color(0xFF344955),
      iconTheme: IconThemeData(
        color: Colors.green,
      ),
      buttonTheme: ButtonThemeData(
        disabledColor: paleGrey,
        buttonColor: Color(0xFFF9AA33),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),

      //Color(0xFF344955)  //F9AA33
      textTheme: getTextTheme(base.textTheme),
      dialogTheme: DialogTheme(

        contentTextStyle: TextStyle(
          color: lightGrey,
          fontFamily: "OpenSans",
        ),
        titleTextStyle: TextStyle(
            color: yellow1,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold
        ),),




    );
  }

  TextTheme getTextTheme(TextTheme base) {
    return base.copyWith(
      headline6: base.headline6.copyWith(color: Colors.blue),
      subtitle2: base.subtitle2.copyWith(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
      bodyText2: base.bodyText2.copyWith(
        fontWeight: FontWeight.bold,
        color: Color(0xFF232F34),
        fontFamily: "OpenSans",
      ),
      // body2: base.body2.copyWith(fontWeight: FontWeight.bold,color: Colors.pink,fontFamily:"Lobster"),
      button: base.button.copyWith(
          letterSpacing: 1,
          color: Color(0xFF232F34),
          fontFamily: "OpenSans",
          fontWeight: FontWeight.bold),
    );
  }
}
