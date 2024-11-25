import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_current_weather_cubit/get_current_weather_cubit.dart';
import 'package:weather_app/cubits/get_current_weather_cubit/get_current_weather_states.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (context) => BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) {
            final weatherModel =
                BlocProvider.of<GetWeatherCubit>(context).weatherModel;
            final themeColor = getThemeColor(weatherModel?.wethearCase);
            log(themeColor.toString());
            return MaterialApp(
              theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    color: themeColor,
                  ),
                  // useMaterial3: true,
                  primarySwatch: themeColor),
              debugShowCheckedModeBanner: false,
              home: const HomeView(),
            );
          },
        ),
      ),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blueGrey;
  } else {
    condition = condition.toLowerCase();
    if (condition == "sunny") return Colors.amber;
    if (condition == "clear") return Colors.orange;
    if (condition == "partly cloudy") return Colors.lightBlue;
    if (condition == "cloudy") return Colors.grey;
    if (condition == "rain") return Colors.blue;
    return Colors.blueGrey;
  }
}
