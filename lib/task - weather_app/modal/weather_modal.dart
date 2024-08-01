class WeatherModal {
  late Location location;
  late Current current;

  WeatherModal({required this.location, required this.current});

  factory WeatherModal.fromJson(Map m1) {
    return WeatherModal(
        location: Location.fromJson(m1['location']),
        current: Current.fromJson(m1['current']));
  }
}

class Location {
  late String name, region, country, tz_id, localtime;

  Location(
      {required this.name,
      required this.region,
      required this.country,
      required this.tz_id,
      required this.localtime,

     });

  factory Location.fromJson(Map m1) {
    return Location(
        name: m1['name'],
        region: m1['region'],
        country: m1['country'],
        tz_id: m1['tz_id'],
        localtime: m1['localtime'],
      );
  }
}

class Current {
  late String last_updated;
  late int last_updated_epoch,wind_degree;
  late double
  temp_c,
      temp_f,
      wind_mph,
      wind_kph,
      vis_miles;
  late int is_day;
  late Condition condition;

  Current(
      {required this.last_updated,
        required this.last_updated_epoch,
        required this.temp_c,
        required this.temp_f,
        required this.wind_mph,
        required this.wind_kph,
        required this.wind_degree,
        required this.vis_miles,
        required this.is_day,
        required this.condition});

  factory Current.fromJson(Map m1) {
    return Current(
      last_updated: m1['last_updated'],
      last_updated_epoch: m1['last_updated_epoch'],
      temp_c: m1['temp_c'],
      temp_f: m1['temp_f'],
      wind_mph: m1['wind_mph'],
      wind_kph: m1['wind_kph'],
      wind_degree: m1['wind_degree'],
      vis_miles: m1['vis_miles'],
      is_day: m1['is_day'],
      condition: Condition.fromJson(
        m1['condition'],
      ),
    );
  }
}


class Condition {
  late String text, icon;
  late int code;

  Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(Map m1) {
    return Condition(text: m1['text'], icon: m1['icon'], code: m1['code']);
  }
}
