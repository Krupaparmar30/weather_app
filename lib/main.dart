import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/task%20-%20weather_app/provider/weather_provider.dart';
import 'package:weather_app/task%20-%20weather_app/view/weather_api_fav/weather_api_fav.dart';
import 'package:weather_app/task%20-%20weather_app/view/weather_api_home_page/weather_api_home_page.dart';
import 'package:weather_app/task%20-%20weather_app/view/weather_api_spl/weather_api_spl.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider(),)
      ],
      
      
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(context)=>spleshPage(),
          '/home':(context)=>weather_api_home_page(),
          '/fav':(context)=>favPage()
        },
      ),
    );
  }
}
