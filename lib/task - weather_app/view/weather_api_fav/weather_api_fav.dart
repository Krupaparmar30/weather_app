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
      appBar: AppBar(
        title: Text('Favre'),
      ),
      body: FutureBuilder(
        future: Provider.of<WeatherProvider>(context, listen: false)
            .fromMap(weatherProviderTrue.searchWeather),
        builder: (context, snapshot) {
          WeatherModal? weatherModal = snapshot.data;
          if (snapshot.hasData) {
            WeatherModal? tmp = snapshot.data;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ...List.generate(
                    weatherProviderTrue.weather.length,
                    (index) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            width: 380,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'city : ${weatherProviderTrue.weather[index]}'),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'temprecher: ${weatherProviderTrue.temprecher[index]}'),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          '${weatherProviderTrue.stu[index]}'),
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
      // SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: Column(
      //     children: [
      //       ...List.generate(
      //         weatherProviderTrue.weather.length,
      //         (index) => Column(
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Container(
      //                 height: 120,
      //                 width: 380,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   color: Colors.white,
      //                 ),
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       children: [
      //                         Padding(
      //                           padding: const EdgeInsets.all(8.0),
      //                           child: Text('city : ${weatherProviderTrue.weather[index]}'),
      //                         ),
      //
      //
      //                       ],
      //                     ),
      //                     Row(
      //                       children: [
      //
      //
      //                         Padding(
      //                           padding: const EdgeInsets.all(8.0),
      //                           child:    Text('temprecher: ${weatherProviderTrue.temprecher[index]}'),
      //                         ),
      //                       ],
      //                     ),
      //                     Row(
      //                       children: [
      //
      //
      //                         Padding(
      //                           padding: const EdgeInsets.all(8.0),
      //                           child:                              Text('${weatherProviderTrue.stu[index]}'),
      //
      //                         ),
      //                       ],
      //                     ),
      //
      //                   ],
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
