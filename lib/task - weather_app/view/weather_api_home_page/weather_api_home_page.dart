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
                height: 750,
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
                    TextField(
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
                          borderSide: BorderSide(width: 1, color: Colors.white),
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
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          weatherProviderFalse
                              .weatherModal!.current.condition.text,
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
                          weatherProviderFalse.weatherModal!.location.region
                              .toString(),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          weatherProviderFalse.weatherModal!.location.country,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),

                        Text(
                          'Temperature : ${weatherProviderFalse.weatherModal!.current.temp_c.toString()} °C',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Ink.image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'http:${weatherProviderFalse.weatherModal!.current.condition.icon}')),
                        ),
                        Text(
                          weatherProviderFalse.weatherModal!.current.wind_kph
                              .toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              weatherProviderTrue
                                  .addFavourite(weatherModal!.location.name);
                              weatherProviderTrue
                                  .addFavouriteTemp(weatherModal.current.temp_c);
                              weatherProviderTrue.addFavouriteStu(
                                  weatherModal.current.condition.text);
                            },
                            icon: Icon(Icons.favorite,color: Colors.white,)),
                        Text(
                          weatherProviderFalse.weatherModal!.current.last_updated,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 200,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(10),

                            ),
                          ),
                        )
                      ],
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
String night = "assets/images/sky3.gif";
String day = "assets/images/sky2.gif";
