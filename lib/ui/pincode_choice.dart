// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:vaccination_portal/ui/schedule_screen.dart';
// import 'package:vaccination_portal/networking/api.dart';
// class Pincode extends StatefulWidget {
//   const Pincode({Key key}) : super(key: key);
//   @override
//   _PincodeState createState() => _PincodeState();
// }
//
// class _PincodeState extends State<Pincode> {
//   var _pincode;
//   Future vList;
//   @override
//   void initState() {
//     // TODO: implement initState
//     vList=VaccineData().getdata();
//     vList=VaccineData().getdata();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Book Appointment for Dose-1"),
//         backgroundColor: Colors.blue.shade900,
//       ),
//       body: FutureBuilder(
//         future: vList,
//         builder: (context, AsyncSnapshot snapshot){
//           return Padding(
//             padding: const EdgeInsets.all(38.0),
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 300,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text("PinCode",style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue.shade900
//                   ),),
//                   Padding(
//                     padding: const EdgeInsets.only(top:8.0),
//                     child: TextField(
//                       decoration: InputDecoration(
//                           hintText: "Enter PinCode",
//                           prefixIcon: Icon(FontAwesomeIcons.search),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)
//                           )
//                       ),
//                       onSubmitted: (value)
//                       {
//                         setState(() {
//                           _pincode=value;
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduleScreen(pincode: _pincode,)));
//                         });
//                       },
//                     ),
//                   ),
//                   //Text("${_pincode}"),
//                   Spacer()
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
