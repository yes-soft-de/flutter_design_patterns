import 'dart:convert';

import 'package:patterns_app/coord_model.dart';
import 'package:patterns_app/fake_server.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  static const int STATUS_CODE_INIT = 784;
  static const int STATUS_CODE_SUCCESS = 785;
  static const int STATUS_CODE_ERROR = 786;
  static const int STATUS_CODE_LOADING = 787;

  static const String KEY_STATUS = 'status';
  static const String KEY_PAYLOAD = 'payload';

  FakeServer _server;

  HomeBloc() {
    _server = new FakeServer();
  }

  PublishSubject<Map<String, dynamic>> _stateSubject = new PublishSubject();

  Stream<Map<String, dynamic>> get stateStream => _stateSubject.stream;

  getWeather() {
    _stateSubject.add({KEY_STATUS: STATUS_CODE_LOADING});
    _server.getWeather().then((value) {
      try {
        CoordModel model = CoordModel.fromJson(jsonDecode(value));
        if (model.lon != null && model.lat != null) {
          _stateSubject
              .add({KEY_STATUS: STATUS_CODE_SUCCESS, KEY_PAYLOAD: model});
        } else {
          _stateSubject.add({KEY_STATUS: STATUS_CODE_ERROR});
        }
      } catch (e) {
        _stateSubject.add({KEY_STATUS: STATUS_CODE_ERROR});
      }
    });
  }

  dispose() {
    _stateSubject.close();
  }
}
