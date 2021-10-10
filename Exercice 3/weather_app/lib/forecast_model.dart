class ForecastModel {
  late num lat;
  late num lon;
  late String timezone;
  late num timezoneOffset;
  late List<Daily> daily;

  ForecastModel(
      this.lat, this.lon, this.timezone, this.timezoneOffset, this.daily);

  ForecastModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] != null ? json['lat'].toDouble() : 0;
    lon = json['lon'] != null ? json['lon'].toDouble() : 0;
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];

    if (json['daily'] != null) {
      daily = [];
      json['daily'].forEach((v) {
        daily.add(Daily.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['timezone'] = timezone;
    data['timezone_offset'] = timezoneOffset;
    data['daily'] = daily.map((v) => v.toJson()).toList();

    return data;
  }
}

class Daily {
  late num dt;
  late num sunrise;
  late num sunset;
  late num moonrise;
  late num moonset;
  late num moonPhase;
  late Temp temp;
  late FeelsLike feelsLike;
  late num pressure;
  late num humidity;
  late num dewPonum;
  late num windSpeed;
  late num windDeg;
  late num windGust;
  late List<Weather> weather;
  late num clouds;
  late num pop;
  late num uvi;
  late num rain;

  Daily(
      this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPonum,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.clouds,
      this.pop,
      this.uvi,
      this.rain);

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'] ?? 0;
    sunrise = json['sunrise'] ?? 0;
    sunset = json['sunset'] ?? 0;
    moonrise = json['moonrise'] ?? 0;
    moonset = json['moonset'] ?? 0;
    moonPhase = json['moon_phase'] != null ? json['moon_phase'].toDouble() : 0;
    temp = json['temp'] != null
        ? Temp.fromJson(json['temp'])
        : Temp(0, 0, 0, 0, 0, 0);
    feelsLike = json['feels_like'] != null
        ? FeelsLike.fromJson(json['feels_like'])
        : FeelsLike(0, 0, 0, 0);
    pressure = json['pressure'] ?? 0;
    humidity = json['humidity'] ?? 0;
    dewPonum = json['dew_ponum'] != null ? json['dew_ponum'].toDouble() : 0;
    windSpeed = json['wind_speed'] != null ? json['wind_speed'].toDouble() : 0;
    windDeg = json['wind_deg'] ?? 0;
    windGust = json['wind_gust'] ?? 0;

    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }

    clouds = json['clouds'] ?? 0;
    pop = json['pop'] != null ? json['pop'].toDouble() : 0;
    uvi = json['uvi'] != null ? json['uvi'].toDouble() : 0;
    rain = json['rain'] != null ? json['rain'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['moonrise'] = moonrise;
    data['moonset'] = moonset;
    data['moon_phase'] = moonPhase;
    data['temp'] = temp.toJson();
    data['feels_like'] = feelsLike.toJson();
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_ponum'] = dewPonum;
    data['wind_speed'] = windSpeed;
    data['wind_deg'] = windDeg;
    data['wind_gust'] = windGust;
    data['weather'] = weather.map((v) => v.toJson()).toList();
    data['clouds'] = clouds;
    data['pop'] = pop;
    data['uvi'] = uvi;
    data['rain'] = rain;

    return data;
  }
}

class Temp {
  late num day;
  late num min;
  late num max;
  late num night;
  late num eve;
  late num morn;

  Temp(this.day, this.min, this.max, this.night, this.eve, this.morn);

  Temp.fromJson(Map<String, dynamic> json) {
    day = (json['day'] != null) ? json['day'].toDouble() : 0;
    min = (json['min'] != null) ? json['min'].toDouble() : 0;
    max = (json['max'] != null) ? json['max'].toDouble() : 0;
    night = (json['night'] != null) ? json['night'].toDouble() : 0;
    eve = (json['eve'] != null) ? json['eve'].toDouble() : 0;
    morn = (json['morn'] != null) ? json['morn'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['min'] = min;
    data['max'] = max;
    data['night'] = night;
    data['eve'] = eve;
    data['morn'] = morn;

    return data;
  }
}

class FeelsLike {
  late num day;
  late num night;
  late num eve;
  late num morn;

  FeelsLike(this.day, this.night, this.eve, this.morn);

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day'] != null ? json['day'].toDouble() : 0;
    night = json['night'] != null ? json['night'].toDouble() : 0;
    eve = json['eve'] != null ? json['eve'].toDouble() : 0;
    morn = json['morn'] != null ? json['morn'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['night'] = night;
    data['eve'] = eve;
    data['morn'] = morn;

    return data;
  }
}

class Weather {
  late num id;
  late String main;
  late String description;
  late String icon;

  Weather(this.id, this.main, this.description, this.icon);

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    main = json['main'] ?? "";
    description = json['description'] ?? "";
    icon = json['icon'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;

    return data;
  }
}
