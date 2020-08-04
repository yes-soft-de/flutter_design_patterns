import 'dart:async';

class FakeServer {
  int requestNumber = 0;

  Future<dynamic> getWeather() async {
    await Future.delayed(Duration(seconds: 3));

    if ((requestNumber + 1) % 3 == 0) {
      requestNumber += 1;
      return '{"lon":-0.13,"lat":51.51}';
    } else if ((requestNumber + 1) % 3 == 1) {
      requestNumber += 1;
      return '{"msg":"Auth error"}';
    } else if ((requestNumber + 1) % 3 == 2) {
      requestNumber += 1;
      return '<html> <some>';
    }
  }
}
