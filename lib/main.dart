import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_portal/ui/TestDB.dart';
import 'package:vaccination_portal/ui/loading_screen.dart';
import 'package:vaccination_portal/ui/main%20screen.dart';
import 'package:vaccination_portal/ui/schedule_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //final AnonymousAuth _auth=AnonymousAuth();
  runApp(MaterialApp(home: Sample(),));
}
