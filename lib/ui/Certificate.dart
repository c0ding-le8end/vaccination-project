import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_portal/util/global_variables.dart';

class Certificate extends StatelessWidget {
  final name, phoneNumber, age, aadharNumber, vaccineType, gender;

  const Certificate(
      {Key key,
        this.name,
        this.phoneNumber,
        this.age,
        this.aadharNumber,
        this.vaccineType,
        this.gender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Certificate"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/vaccine_watermark.png"),
                            alignment: Alignment.bottomCenter,
                            colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.15), BlendMode.dstIn),scale: 0.5
                        )),
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(
                            "images/Logo.png",
                            width: 175,
                            height: 175,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Vaccination Details",
                                style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color:darkGrey, fontFamily: "OpenSans"),
                              ),
                            )
                          ],
                        ),
                        Table(
                          border: TableBorder.symmetric(outside: BorderSide(
                            width:2,
                          )),
                          defaultVerticalAlignment: TableCellVerticalAlignment.top,
                          children: <TableRow>[
                            TableRow(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,6,5,0),
                                  child: Container(
                                    // height: 30,
                                    child:
                                    Text(
                                      "Name",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.top,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(5,6,5,0),
                                    child: Container(
                                      child: Wrap(
                                        children: [Text(
                                          "${name[0].toUpperCase()}${name.substring(1)}",
                                          style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                        ),]
                                      ),
                                      // height: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,6,5,0),
                                  child: Container(
                                    // height: 35,
                                    child: Text(
                                      "Age",
                                      style: TextStyle(fontSize: 20.0),
                                    ),

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,6,5,0),
                                  child: Container(
                                    // height: 30,
                                    child: Text(
                                      "$age",
                                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,6,5,0),
                                  child: Container(
                                    // height: 30,
                                    child:
                                    Text(
                                      "Gender",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.top,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(5,6,5,0),
                                    child: Container(
                                      child: Text(
                                        "$gender",
                                        style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                      ),
                                      // height: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,6,5,0),
                                  child: Container(
                                    child: Text(
                                      "Phone Number",
                                      style: TextStyle(fontSize: 20.0),
                                    ),

                                    // height: 40,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,6,5,0),
                                  child: Container(
                                    child: Text(
                                      "$phoneNumber",
                                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                    ),
                                    // height: 40,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,6,5,0),
                                  child: Container(
                                    child: Text(
                                      "Aadhar Number",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    // height: 40,
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.top,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(5,6,5,0),
                                    child: Container(
                                      child: Text(
                                        "$aadharNumber",
                                        style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                      ),
                                      // height: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,6,5,0),
                                  child: Container(
                                    child: Text(
                                      "Vaccine Name",
                                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                    ),

                                    // height: 40,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,6,5,5),
                                  child: Container(
                                    child: Text(
                                      "$vaccineType",
                                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                    ),
                                    // height: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}