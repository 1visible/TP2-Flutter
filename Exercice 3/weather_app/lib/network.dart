import 'dart:convert';

import 'package:http/http.dart';

import 'api.dart';
import 'forecast_model.dart';
import 'weather_model.dart';

class Network {
  Future<WeatherModel?> getWeather({required String query}) async {
    var url = "${API.URL}/weather?q=$query&appid=${API.KEY}&lang=fr";
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<ForecastModel?> getForecast(
      {required double lon, required double lat}) async {
    var url =
        "${API.URL}/onecall?lat=$lat&lon=$lon&exclude=${API.EXCLUDES}&appid=${API.KEY}";
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return ForecastModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
