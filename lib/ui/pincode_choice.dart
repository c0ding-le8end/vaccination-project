import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vaccination_portal/ui/schedule_screen.dart';
import 'package:vaccination_portal/util/global_variables.dart';
import '../util/get_date.dart';

class Pincode extends StatefulWidget {
  final String? status;
  final String? vaccineType;
  final dose1Date;

  const Pincode({this.status, Key? key, this.vaccineType, this.dose1Date})
      : super(key: key);

  @override
  _PincodeState createState() => _PincodeState(status!, vaccineType!, dose1Date);
}

class _PincodeState extends State<Pincode> {
  var _pincode;
  Future? vList;
  var date;
  final String? vStatus;
  final String? _vaccineType;
  final _dose1Date;

  _PincodeState(this.vStatus, this._vaccineType, this._dose1Date);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment",
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w900,
                fontSize: 24,
                fontStyle: FontStyle.normal,
                letterSpacing: 1)),
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: vList,
        builder: (context, AsyncSnapshot snapshot) {
          return Padding(
            padding: const EdgeInsets.all(38.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "PinCode",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: yellow1, width: 3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: TextStyle(fontSize: 19.0),
                          decoration: InputDecoration(
                              counterText: "",
                              hintText: "Enter PinCode",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              prefixIcon: Icon(FontAwesomeIcons.search),
                              border: InputBorder.none),
                          maxLength: 6,
                          cursorColor: yellow1,
                          keyboardType: TextInputType.number,
                          onSubmitted: (value) {
                            setState(() {
                              _pincode = value;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) {
                                        chosenDate=DateGet.getCurrentDate();
                                        return ScheduleScreen(
                                            pincode: _pincode,
                                            vStatus: vStatus!,
                                            currentDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                            vaccineType: _vaccineType!,
                                            dose1Date: _dose1Date);
                                      }));
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  //Text("${_pincode}"),
                  Spacer()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
