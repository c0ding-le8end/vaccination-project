//API extracted from https://apisetu.gov.in/public/api/cowin#/Appointment%20Availability%20APIs/findByDistrict

import 'dart:convert';

import 'package:http/http.dart';
import 'package:vaccination_portal/networking/formatted_api.dart';

class VaccineData
{
  String url="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=560011&date=30-05-2021";
 Future getdata() async
 {
   Response response=await get(Uri.encodeFull(url));
   if(response.statusCode==200)
     {
        return VaccineObject.fromJson(json.decode(response.body));
     }
   else
     {
       throw Exception("Error recieving data");
     }
 }
}