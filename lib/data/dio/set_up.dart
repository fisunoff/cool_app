import 'package:cool_app/di/di.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';


void setUpDio() {
  dio.options.baseUrl = 'http://api.openweathermap.org/data/2.5/forecast?';
  dio.options.queryParameters.addAll({
    'lat': 56.07,
    'lon': 47.14,
    'cnt': 40,
    'units': 'metric',
    'appid': '0b4cdf94c783bd32772c085dfcbb195b',
  });
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 5);
  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      ),
    ),
  ]);
}