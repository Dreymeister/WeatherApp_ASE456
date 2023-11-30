import 'package:flutter/material.dart';

import 'weather.dart';

abstract class CheckNotification {
  bool checkEmergency(var weatherData);
  bool checkAlert(var weatherData, var userSettings);
}

class CheckLocation extends CheckNotification {
  bool notify = false;
  String message = '';
  var userSettings = {'temperature': true, 'visibility': true, 'wind': true};
  @override
  bool checkEmergency(var weatherData) {
    String emergencyMessage = '';
    if (weatherData != null) {
      if (weatherData['main']['temp'] > 37.78) {
        notify = true;
        emergencyMessage +=
            'EMERGENCY: The temperature is ${(((weatherData['main']['temp']) * (9 / 5)) + 32).floor()}F - STAY INDOORS!\n';
      } else if (weatherData['main']['temp'] < -15) {
        notify = true;
        emergencyMessage +=
            'EMERGENCY: The temperature is ${(((weatherData['main']['temp']) * (9 / 5)) + 32).floor()}F - STAY INDOORS\n';
      }
      if (weatherData['visibility'] < 100) {
        notify = true;
        emergencyMessage +=
            'EMERGENCY: The visibility is about ${(weatherData['visibility'] / 1609).floor()}mi - USE CAUTION WHEN DRIVING\n';
      }
      if (weatherData['wind']['speed'] > 44.704) {
        notify = true;
        emergencyMessage +=
            'EMERGENCY: wind gusts are at ${(weatherData['wind']['speed'] * 2.23694).floor()} mph\n';
      }
    }
    message += emergencyMessage;
    return notify;
  }

  @override
  bool checkAlert(var weatherData, var userSettings) {
    String alertMessage = '';
    if (weatherData != null) {
      if (userSettings['temperature']!) {
        notify = true;
        alertMessage += 'ALERT: return true and apped message temp\n';
      }
      if (userSettings['visibility']!) {
        notify = true;
        alertMessage += 'ALERT: return true and apped message visibility\n';
      }
      if (userSettings['wind']!) {
        notify = true;
        alertMessage += 'ALERT: return true and apped message wind\n';
      }
    }
    message += alertMessage;
    return notify;
  }
}
