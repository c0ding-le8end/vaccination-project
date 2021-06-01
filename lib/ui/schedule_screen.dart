import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccination_portal/networking/api.dart';
import 'package:vaccination_portal/networking/formatted_api.dart';

class Pincode extends StatefulWidget {
  const Pincode({Key key}) : super(key: key);
  @override
  _PincodeState createState() => _PincodeState();
}

class _PincodeState extends State<Pincode> {
  var _pincode;
  Future vList;
  @override
  void initState() {
    // TODO: implement initState
    vList=VaccineData().getdata();
    vList=VaccineData().getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment for Dose-1"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: FutureBuilder(
        future: vList,
        builder: (context, AsyncSnapshot snapshot){
          return Padding(
            padding: const EdgeInsets.all(38.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("PinCode",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Enter PinCode",
                          prefixIcon: Icon(FontAwesomeIcons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                        keyboardType: TextInputType.number,
                      onSubmitted: (value)
                      {
                        setState(() {
                          _pincode=value;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduleScreen(pincode: _pincode,)));
                        });
                      },
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

class ScheduleScreen extends StatefulWidget {
  final String pincode;
  const ScheduleScreen({Key key, this.pincode}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState(pincode);
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  Future<VaccineObject> vlist;
  final String _pincode;

  _ScheduleScreenState(this._pincode);
  @override
  // TODO: implement widget
  ScheduleScreen get widget {
    super.widget;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vlist = getpincode(pincode: _pincode);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Appointment for Dose-1"),
          backgroundColor: Colors.blue.shade900,
      ),
      body: InkWell(
        child: FutureBuilder(
          future: vlist, builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.sessions.length,
              scrollDirection:Axis.vertical,
              itemBuilder: (context,int index)
              {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.blue,
                  child: Card(
                    //color: Colors.blue.shade900,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>
                          [
                            Text("${snapshot.data.sessions[index].name}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16),),
                          ]
                        ),
                      ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                           //height: 50,
                             width: MediaQuery.of(context).size.width,
                             child: Row(
                           children: [
                             Expanded(child: Text("${snapshot.data.sessions[index].address}",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black))),
                             Text("${snapshot.data.sessions[index].blockName}")
                             //Text("${snapshot.data.sessions[index].blockName}"),
                           ],
                         )),
                       ),
                       // Padding(
                       //   padding: const EdgeInsets.only(top :8.0,bottom: 8),
                       //   child: Container(
                       //     height: 0.5, color: Colors.grey,
                       //   ),
                       // ),
                      ],
                    ),
                  )
                );
              }
              ,);
          }
          else
            return Container(child: Center(child: CircularProgressIndicator(),));
        },
        ),
       onTap: () => debugPrint("Test"),
      ),
    );
  }
  Future<VaccineObject> getpincode({String pincode}) =>
      VaccineData().getdata(pincode: pincode);

}

