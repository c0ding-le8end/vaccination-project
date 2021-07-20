
import 'package:intl/intl.dart';
// ignore: camel_case_types
class DateGet
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