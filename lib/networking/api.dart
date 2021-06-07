//API extracted from https://apisetu.gov.in/public/api/cowin#/Appointment%20Availability%20APIs/findByDistrict

import 'dart:convert';

import 'package:http/http.dart';
import 'package:vaccination_portal/networking/formatted_api.dart';

import '../random.dart';

class VaccineData
{


  Future<VaccineObject> getdata({String pincode, var date}) async
  {
    var today = Date_Get.getCurrentDate();
    //var newDate=Date_Get.getNewDate(0);
    var newDate= date==null?Date_Get.getNewDate(0):date;
    var url="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode="+pincode+"&date="+newDate;
    print("$url");
    //var url="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=%22+pincode+%22&date=%22+$today";
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