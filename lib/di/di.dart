import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:dio/dio.dart';

import '../data/dio/set_up.dart';
import '../app/features/home/temperature_bloc.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();

final Dio dio = Dio();

Future<void> setupLocator() async {
  setUpDio();
  
  // Регистрируем Dio и Talker в GetIt
  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<Talker>(talker);
  
  getIt.registerSingleton<TemperatureBloc>(TemperatureBloc());
}