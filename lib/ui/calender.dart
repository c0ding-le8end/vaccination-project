// ignore: avoid_web_libraries_in_flutter
import 'package:http/http.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaccination_portal/random.dart';

class Calender extends StatefulWidget {
  const Calender({Key key}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text("Choose Date"),
      content: Container(
        child: RadioListBuilder(
        ),
        width: 150,
        height: 150,
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'))
      ],
    );
  }
}

class RadioListBuilder extends StatefulWidget {
  const RadioListBuilder({Key key}) : super(key: key);

  @override
  _RadioListBuilderState createState() => _RadioListBuilderState();
}

class _RadioListBuilderState extends State<RadioListBuilder> {
  int id=0;
  String init_date = Date_Get.getCurrentDate();
  List<DateObject> week = [
    DateObject(
      index: 0,
      date: Date_Get.getCurrentDate()
    ),
    DateObject(
        index: 1,
        date: Date_Get.getNewDate(1)
    ),
    DateObject(
        index: 2,
        date: Date_Get.getNewDate(2)
    ),
    DateObject(
        index: 3,
        date: Date_Get.getNewDate(3)
    ),
    DateObject(
        index: 4,
        date: Date_Get.getNewDate(4)
    ),
    DateObject(
        index: 5,
        date: Date_Get.getNewDate(5)
    ),
    DateObject(
        index: 6,
        date: Date_Get.getNewDate(6)
    )
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Container(
        child:Column(
          children:
            week.map((data) => RadioListTile(
                title: Text(("${data.date}")),
                value: data.index, groupValue: id, onChanged: (val)
            {
              setState(() {
                init_date=data.date;
                id=data.index;
              });
            })).toList(),
        )

      ),]
    );}
}


class DateObject
{
  int index;

  DateObject({this.index, this.date});

  var date;
}
