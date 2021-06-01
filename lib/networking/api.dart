//API extracted from https://apisetu.gov.in/public/api/cowin#/Appointment%20Availability%20APIs/findByDistrict

import 'dart:convert';

import 'package:http/http.dart';
import 'package:vaccination_portal/networking/formatted_api.dart';

class VaccineData
{

 Future<VaccineObject> getdata({String pincode}) async
 {
   var url="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode="+pincode+"&date=01-06-2021";
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