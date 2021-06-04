import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calender extends StatelessWidget {
  const Calender({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose Date"),
      content: Container(
    child: ListView(
      scrollDirection: Axis.vertical,
      children: [Text("data"), Text("data")],
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
