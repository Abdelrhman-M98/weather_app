import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Services/weather_services.dart';
import 'package:weather_app/cubits/get_current_weather_cubit/get_current_weather_states.dart';
import 'package:weather_app/models/weather_model.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(WeatherInitialState());
  WeatherModel? weatherModel;
  getCurrentWeather({required String cityName}) async {
    try {
      weatherModel = await WeatherServices(dio: Dio())
          .getCurrentWeather(cityName: cityName);
      emit(WeatherLoadState(weatherModel: weatherModel!));
    } catch (e) {
      emit(WeatherErrorState(errorMessage: e.toString()));
    }
  }
}
