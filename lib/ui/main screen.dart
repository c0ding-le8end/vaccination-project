import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_portal/networking/api.dart';

class Sample extends StatefulWidget {
  const Sample({Key key}) : super(key: key);

  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  Future vList;

  @override
  void initState() {
    vList = VaccineData().getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Vaccine app"),),
      body: FutureBuilder(
        future: vList, builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.sessions.length,
            scrollDirection:Axis.vertical,
            itemBuilder: (context,int index)
            {
              return Container(child: Center(child: Text("${snapshot.data.sessions[index].name}"),),);
            }
            ,);
        }
        else
          return Container(child: Center(child: CircularProgressIndicator(),));
      },),
    );
  }
}

