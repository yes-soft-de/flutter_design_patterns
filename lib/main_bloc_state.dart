import 'package:patterns_app/coord_model.dart';

abstract class WeatherBlocState {
}

class WeatherStateInit extends WeatherBlocState {}

class WeatherStateRefreshing extends WeatherBlocState {}

class WeatherStateLoadSuccess extends WeatherBlocState {
  CoordModel model;
  WeatherStateLoadSuccess(this.model);
}

class WeatherStateLoadError extends WeatherBlocState {}