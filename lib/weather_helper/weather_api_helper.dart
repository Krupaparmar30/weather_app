import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class WeatherApiHelper{
  Future<Map> weather(String search)


  async {
    String api="http://api.weatherapi.com/v1/current.json?key=0986c67e586547e4b37102458243007&q=$search";

    Uri url=Uri.parse(api);
   Response response =await http.get(url);
   if(response.statusCode==200)
     {
       final json=response.body;
       Map data = jsonDecode(json);
       return data;

     }
   else
     {
       return {};
     }
 }
}