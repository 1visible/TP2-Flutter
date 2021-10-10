import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/forecast_model.dart';
import 'package:weather_app/weather_model.dart';

import 'cubit.dart';
import 'network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: BlocProvider(
          create: (context) => QueryCubit(), child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final _date_format;
  late final _day_format;
  final _controller = TextEditingController();
  final _network = Network();
  ForecastModel _forecast_data = ForecastModel(0, 0, "", 0, []);
  WeatherModel _weather_data = WeatherModel(
      Coord(0, 0),
      [],
      "",
      Main(0, 0, 0, 0, 0, 0),
      0,
      Wind(0, 0),
      Clouds(0),
      Rain(0, 0),
      0,
      Sys(0, 0, "", 0, 0),
      0,
      0,
      "",
      0);

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _date_format = DateFormat('EEEE d MMMM y, H:mm', 'fr');
    _day_format = DateFormat('EEEE', 'fr');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(102, 111, 203, 1),
              Color.fromRGBO(64, 178, 255, 1),
            ]),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      fillColor: Color.fromRGBO(255, 255, 255, 0.2),
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Entrez un nom de ville...",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) {
                      context.read<QueryCubit>().emit(value);
                    },
                  ),
                  BlocBuilder<QueryCubit, String>(builder: (context, query) {
                    return FutureBuilder<WeatherModel?>(
                        future: _network.getWeather(query: query),
                        builder: (context, snapshot) {
                          if (!snapshot.hasError &&
                              snapshot.hasData &&
                              _weather_data != snapshot.data) {
                            _weather_data = snapshot.data!;
                            return getWeatherWidget();
                          } else if (snapshot.hasError) {
                            return getErrorWidget(
                                MediaQuery.of(context).size.height * 0.8);
                          } else {
                            return getLoadingWidget(
                                MediaQuery.of(context).size.height * 0.8);
                          }
                        });
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget getWeatherWidget() {
    String _date = _date_format.format(DateTime.now());
    _date = _date[0].toUpperCase() + _date.substring(1);

    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        RichText(
          text: TextSpan(
            children: [
              const WidgetSpan(
                child: Icon(Icons.location_on, size: 20),
              ),
              TextSpan(
                text: ' ${_weather_data.name}, ${_weather_data.sys.country}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Text(
          _date,
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.6),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 2,
            maxHeight: MediaQuery.of(context).size.height / 2.5,
          ),
          child: getWeatherIcon(_weather_data.weather.first.main),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${toCelsius(_weather_data.main.temp)}°C',
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(_weather_data.weather.first.description.toUpperCase()),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${toKmh(_weather_data.wind.speed)} km/h',
                ),
                const SizedBox(
                  height: 5,
                ),
                const Icon(
                  FontAwesomeIcons.wind,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_weather_data.main.humidity}%',
                ),
                const SizedBox(
                  height: 5,
                ),
                const Icon(
                  FontAwesomeIcons.tint,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_weather_data.rain.d3h.round()} mm',
                ),
                const SizedBox(
                  height: 5,
                ),
                const Icon(
                  FontAwesomeIcons.water,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        const Text(
          'Prévisions pour les 7 prochains jours',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        FutureBuilder<ForecastModel?>(
          future: _network.getForecast(
              lon: _weather_data.coord.lon, lat: _weather_data.coord.lat),
          builder: (context, snapshot) {
            if (!snapshot.hasError &&
                snapshot.hasData &&
                _forecast_data != snapshot.data) {
              _forecast_data = snapshot.data!;
              return getForecastWidget();
            } else if (snapshot.hasError) {
              return getErrorWidget(100);
            } else {
              return getLoadingWidget(100);
            }
          },
        ),
      ],
    );
  }

  Widget getErrorWidget(double height) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: const Center(
        child: Text(
          'Une erreur est survenue...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget getLoadingWidget(double height) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getForecastWidget() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _forecast_data.daily.length,
        itemBuilder: (context, index) {
          Daily _daily = _forecast_data.daily[index];
          DateTime _today = DateTime.now();
          String _date = _day_format.format(
              DateTime(_today.year, _today.month, _today.day + index + 1));
          _date = _date[0].toUpperCase() + _date.substring(1);

          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Container(
              width: 150,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.2),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 50,
                        child: getWeatherIcon(_daily.weather.first.main),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                const WidgetSpan(
                                  child: Icon(Icons.arrow_circle_up, size: 18),
                                ),
                                TextSpan(
                                  text: ' ${toCelsius(_daily.temp.max)}°C',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                const WidgetSpan(
                                  child:
                                      Icon(Icons.arrow_circle_down, size: 18),
                                ),
                                TextSpan(
                                  text: ' ${toCelsius(_daily.temp.min)}°C',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getWeatherIcon(String weather) {
    List<String> weathers = ["Clear", "Clouds", "Rain", "Snow"];

    return weathers.contains(weather)
        ? Image.asset("images/$weather.png")
        : Image.asset("images/Clear.png");
  }

  int toCelsius(num temperature) {
    return (temperature - 274).round();
  }

  int toKmh(double speed) {
    return (speed * 1.609344).round();
  }
}
