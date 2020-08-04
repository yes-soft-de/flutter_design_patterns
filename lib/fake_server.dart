import 'dart:async';

class FakeServer {
  int requestNumber = 0;

  Future<String> getWeather() async {
    await Future.delayed(Duration(seconds: 5));
    int state = (requestNumber) % 3;
    requestNumber++;
    if (state == 0) {
      return '{"lon":-0.13,"lat":51.51}';
    } else if (state == 1) {
      return '{"msg":"Auth error"}';
    } else {
      return '<html> <some>';
    }
  }
}
