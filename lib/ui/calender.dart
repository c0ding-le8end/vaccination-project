// ignore: avoid_web_libraries_in_flutter
import 'package:http/http.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaccination_portal/random.dart';
import 'package:vaccination_portal/ui/schedule_screen.dart';

String chosenDate;

class Calender extends StatefulWidget {
  final String vaccineType;
  final int todayDate;
  final dose1Date;
  final String vStatus;

  const Calender({Key key, this.vaccineType, this.todayDate, this.dose1Date, this.vStatus})
      : super(key: key);

  @override
  _CalenderState createState() =>
      _CalenderState(vaccineType, todayDate, dose1Date,vStatus);
}

class _CalenderState extends State<Calender> {
  final String _vaccineType;
  final int _todayDate;
  final _dose1Date;
  final String _vStatus;
  _CalenderState(this._vaccineType, this._todayDate, this._dose1Date, this._vStatus);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose Date"),
      content: Container(
        child: RadioListBuilder(todayDate: _todayDate),
        width: 150,
        height: 150,
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel')),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ScheduleScreen(
                        pincode: selectedPincode,
                        currentDate: chosenDate,
                        vaccineType: _vaccineType,
                    vStatus: _vStatus,
                    dose1Date: _dose1Date,
                      )));
            },
            child: Text('OK')),
      ],
    );
  }
}

class RadioListBuilder extends StatefulWidget {
  final int todayDate;

  const RadioListBuilder({Key key, this.todayDate}) : super(key: key);

  @override
  _RadioListBuilderState createState() => _RadioListBuilderState(todayDate);
}

class _RadioListBuilderState extends State<RadioListBuilder> {
  final int _todayDate;

  _RadioListBuilderState(this._todayDate);

  int id = 0;
  String init_date; //Date_Get.getCurrentDate();
  @override
  void initState() {
    super.initState();
    init_date = Date_Get.getCurrentDate();
    id = _todayDate;
  }

  List<DateObject> week = [
    DateObject(index: 0, date: Date_Get.getCurrentDate()),
    DateObject(index: 1, date: Date_Get.getNewDate(1)),
    DateObject(index: 2, date: Date_Get.getNewDate(2)),
    DateObject(index: 3, date: Date_Get.getNewDate(3)),
    DateObject(index: 4, date: Date_Get.getNewDate(4)),
    DateObject(index: 5, date: Date_Get.getNewDate(5)),
    DateObject(index: 6, date: Date_Get.getNewDate(6))
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
          child: Column(
        children: week
            .map((data) => RadioListTile(
                title: Text(("${data.date}")),
                value: data.index,
                groupValue: id,
                onChanged: (val) {
                  setState(() {
                    init_date = data.date;
                    id = data.index;
                  });
                  chosenDate = init_date;
                }))
            .toList(),
      )),
    ]);
  }
}

class DateObject {
  int index;

  DateObject({this.index, this.date});

  var date;
}
