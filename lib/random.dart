import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

class Date_Get
{
  static getCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }
  static getNewDate(int num)
  {
    var newDate= DateTime.now().add(new Duration(days: num));
    var formatter = new DateFormat('dd-MM-yyyy');
    return formatter.format(newDate);
  }
}