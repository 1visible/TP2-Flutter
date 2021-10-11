class WeatherModel {
  late Coord coord;
  late List<Weather> weather;
  late String base;
  late Main main;
  late num visibility;
  late Wind wind;
  late Clouds clouds;
  late Rain rain;
  late num dt;
  late Sys sys;
  late num timezone;
  late num id;
  late String name;
  late num cod;

  WeatherModel(
      this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.rain,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod);

  WeatherModel.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : Coord(0, 0);
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }
    base = json['base'] ?? "";
    main = json['main'] != null
        ? Main.fromJson(json['main'])
        : Main(0, 0, 0, 0, 0, 0);
    visibility = json['visibility'] ?? 0;
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : Wind(0, 0);
    clouds =
        json['clouds'] != null ? Clouds.fromJson(json['clouds']) : Clouds(0);
    rain = json['rain'] != null ? Rain.fromJson(json['rain']) : Rain(0, 0);
    dt = json['dt'] ?? 0;
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : Sys(0, 0, "", 0, 0);
    timezone = json['timezone'] ?? 0;
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    cod = json['cod'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['coord'] = coord.toJson();
    data['weather'] = weather.map((v) => v.toJson()).toList();
    data['base'] = base;
    data['main'] = main.toJson();
    data['visibility'] = visibility;
    data['wind'] = wind.toJson();
    data['clouds'] = clouds.toJson();
    data['rain'] = rain.toJson();
    data['dt'] = dt;
    data['sys'] = sys.toJson();
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;

    return data;
  }
}

class Coord {
  late num lon;
  late num lat;

  Coord(this.lon, this.lat);

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'] != null ? json['lon'].toDouble() : 0;
    lat = json['lat'] != null ? json['lat'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;

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

class Main {
  late num temp;
  late num feelsLike;
  late num tempMin;
  late num tempMax;
  late num pressure;
  late num humidity;

  Main(this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure,
      this.humidity);

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] != null ? json['temp'].toDouble() : 0;
    feelsLike = json['feels_like'] != null ? json['feels_like'].toDouble() : 0;
    tempMin = json['temp_min'] != null ? json['temp_min'].toDouble() : 0;
    tempMax = json['temp_max'] != null ? json['temp_max'].toDouble() : 0;
    pressure = json['pressure'] ?? 0;
    humidity = json['humidity'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;

    return data;
  }
}

class Wind {
  late num speed;
  late num deg;

  Wind(this.speed, this.deg);

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'] != null ? json['speed'].toDouble() : 0;
    deg = json['deg'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;

    return data;
  }
}

class Clouds {
  late num all;

  Clouds(this.all);

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;

    return data;
  }
}

class Sys {
  late num type;
  late num id;
  late String country;
  late num sunrise;
  late num sunset;

  Sys(this.type, this.id, this.country, this.sunrise, this.sunset);

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? 0;
    id = json['id'] ?? 0;
    country = json['country'] ?? "";
    sunrise = json['sunrise'] ?? 0;
    sunset = json['sunset'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;

    return data;
  }
}

class Rain {
  late num d1h;
  late num d3h;

  Rain(this.d3h, this.d1h);

  Rain.fromJson(Map<String, dynamic> json) {
    d3h = json['3h'] != null ? json['3h'].toDouble() : 0;
    d1h = json['1h'] != null ? json['1h'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['3h'] = d3h;
    data['1h'] = d1h;

    return data;
  }
}
