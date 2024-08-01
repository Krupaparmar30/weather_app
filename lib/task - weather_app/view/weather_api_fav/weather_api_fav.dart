import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modal/weather_modal.dart';
import '../../provider/weather_provider.dart';

class favPage extends StatelessWidget {
  const favPage({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProviderTrue = Provider.of(context, listen: true);
    WeatherProvider weatherProviderFalse = Provider.of(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<WeatherProvider>(context, listen: false)
            .fromMap(weatherProviderTrue.searchWeather),
        builder: (context, snapshot) {
          WeatherModal? weatherModal = snapshot.data;
          if (snapshot.hasData) {
            WeatherModal? tmp = snapshot.data;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 800,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/fav.gif'))),
                child: Column(
                  children: [
                    ...List.generate(
                      weatherProviderTrue.weather.length,
                      (index) => Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 140,
                              width: 380,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white60,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'City : ${weatherProviderTrue.weather[index]}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'temprecher: ${weatherProviderTrue.temprecher[index]}',     style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '${weatherProviderTrue.stu[index]}',     style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
