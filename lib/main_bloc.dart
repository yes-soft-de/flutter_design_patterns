import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patterns_app/coord_model.dart';
import 'package:patterns_app/fake_server.dart';
import 'package:patterns_app/main_bloc_event.dart';
import 'package:patterns_app/main_bloc_state.dart';

class MainBloc extends Bloc<int, WeatherBlocState> {
  WeatherBlocState currentState;
  FakeServer server = new FakeServer();

  MainBloc(WeatherBlocState initialState) : super(initialState);

  @override
  Stream<WeatherBlocState> mapEventToState(int event) async* {
    print("Got Event");
    if (event == MainBlocEvent.EVENT_REFRESH) {
      getWeather();
      yield WeatherStateRefreshing();
    }
    if (event == MainBlocEvent.EVENT_REQUEST_FINISHED) {
      yield currentState;
    }
  }

  getWeather() async {
    String strResponse = await server.getWeather();
    print(strResponse);
    try {
      CoordModel model = CoordModel.fromJson(jsonDecode(strResponse));
      if (model.lat != null && model.lon != null) {
        print('Success');
        currentState = WeatherStateLoadSuccess(model);
      } else {
        print('Error, Null Data');
        currentState = WeatherStateLoadError();
      }
    } catch (e) {
      print('Error Decoding Data');
      currentState = WeatherStateLoadError();
    }
    this.add(MainBlocEvent.EVENT_REQUEST_FINISHED);
  }
}