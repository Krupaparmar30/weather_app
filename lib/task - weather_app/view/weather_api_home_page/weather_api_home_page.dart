import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/task%20-%20weather_app/modal/weather_modal.dart';
import 'package:weather_app/task%20-%20weather_app/provider/weather_provider.dart';

class weather_api_home_page extends StatelessWidget {
  const weather_api_home_page({super.key, this.city});

  final String? city;

  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProviderTrue =
        Provider.of<WeatherProvider>(context, listen: true);
    WeatherProvider weatherProviderFalse =
        Provider.of<WeatherProvider>(context, listen: false);

    if (city != null &&
        city!.isNotEmpty &&
        weatherProviderFalse.weatherModal == null) {
      weatherProviderFalse.searchWeather;
    }
    String backgroundImage = "assets/images/sky2.gif";
    if (weatherProviderFalse.weatherModal != null) {
      String condition = weatherProviderTrue
          .weatherModal!.current.condition.text
          .toLowerCase();
      if (condition.contains('fair')) {
        backgroundImage = 'assets/images/sky2.gif';
      } else if (condition.contains('rain')) {
        backgroundImage = 'assets/images/sky3.gif';
      } else if (condition.contains('partly cloudy')) {
        backgroundImage = 'assets/images/sky4.gif';
      }
    }
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<WeatherProvider>(context, listen: false)
            .fromMap(weatherProviderFalse.searchWeather),
        builder: (context, snapshot) {
          WeatherModal? weatherModal = snapshot.data;
          if (snapshot.hasData) {
            WeatherModal? tmp = snapshot.data;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 850,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(backgroundImage),
                  opacity: 2.0,
                  filterQuality: FilterQuality.low,
                )),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: TextField(
                        controller: txtWeather,
                        onSubmitted: (value) {
                          weatherProviderFalse.searchWeatherAll(value);
                        },
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          counterStyle: TextStyle(color: Colors.white),
                          labelText: "Search",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 280),
                      child: Text(
                        weatherProviderFalse.weatherModal!.current.is_day == 1
                            ? day
                            : night,
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            weatherProviderFalse
                                .weatherModal!.current.condition.text,
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            weatherProviderFalse.weatherModal!.location.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            weatherProviderFalse.weatherModal!.location.country,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '${weatherProviderFalse.weatherModal!.current.temp_c.toString()} °C',
                            style: TextStyle(fontSize: 32, color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Ink.image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'http:${weatherProviderFalse.weatherModal!.current.condition.icon}')),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  weatherProviderFalse
                                      .weatherModal!.current.last_updated,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                IconButton(
                                    onPressed: () {
                                      weatherProviderTrue.addFavourite(
                                          weatherModal!.location.name);
                                      weatherProviderTrue.addFavouriteTemp(
                                          weatherModal.current.temp_c);
                                      weatherProviderTrue.addFavouriteStu(
                                          weatherModal.current.condition.text);
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.black45,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Text(
                                                    "SUN",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Text(
                                                  "DAY",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.black45,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Text(
                                                  "MON",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Text(
                                                "DAY",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.black45,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Text(
                                                    "TUS",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Text(
                                                  "DAY",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.black45,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Text(
                                                  "WENDS",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Text(
                                                "DAY",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.black45,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Text(
                                                    "THU",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Text(
                                                  "DAY",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.black45,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Text(
                                                    "FRI",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Text(
                                                  "DAY",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.black45,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Image(
                                                    image: NetworkImage(
                                                        'http:${weatherProviderFalse.weatherModal!.current.condition.icon}')),
                                                Text(
                                                  "Temp_c",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  weatherProviderFalse
                                                      .weatherModal!
                                                      .current
                                                      .temp_c
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 120,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.black45,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              Image(
                                                  image: NetworkImage(
                                                      'http:${weatherProviderFalse.weatherModal!.current.condition.icon}')),
                                              Text(
                                                "Wind_degree",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                weatherProviderFalse
                                                    .weatherModal!
                                                    .current
                                                    .wind_degree
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.black45,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image(
                                                      image: NetworkImage(
                                                          'http:${weatherProviderFalse.weatherModal!.current.condition.icon}')),
                                                  Text(
                                                    "Wind_kph",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    weatherProviderFalse
                                                        .weatherModal!
                                                        .current
                                                        .wind_kph
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.black45,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              Image(
                                                  image: NetworkImage(
                                                      'http:${weatherProviderFalse.weatherModal!.current.condition.icon}')),
                                              Text(
                                                "Temp_c",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                weatherProviderFalse
                                                    .weatherModal!
                                                    .current
                                                    .temp_c
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.black45,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image(
                                                      image: NetworkImage(
                                                          'http:${weatherProviderFalse.weatherModal!.current.condition.icon}')),
                                                  Text(
                                                    "Vis_miles",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    weatherProviderFalse
                                                        .weatherModal!
                                                        .current
                                                        .vis_miles
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.black45,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image(
                                                      image: NetworkImage(
                                                          'http:${weatherProviderFalse.weatherModal!.current.condition.icon}')),
                                                  Text(
                                                    "Wind_mph",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    weatherProviderFalse
                                                        .weatherModal!
                                                        .current
                                                        .wind_mph
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/fav');
        },
        child: Icon(Icons.favorite),
      ),
    );
  }
}

TextEditingController txtWeather = TextEditingController();
String night = "Night";
String day = "Day";
