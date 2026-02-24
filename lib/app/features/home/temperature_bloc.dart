import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../widgets/temperature_content.dart';

part 'temperature_event.dart';
part 'temperature_state.dart';

class TemperatureBloc extends Bloc<TemperatureEvent, TemperatureState> {
  final Dio dio = GetIt.I<Dio>(); // Получаем Dio из GetIt
  final Talker talker = GetIt.I<Talker>(); // Получаем Talker из GetIt

  TemperatureBloc() : super(TemperatureInitial()) {
    on<TemperatureLoad>(_onTemperatureLoad);
  }

  Future<void> _onTemperatureLoad(
    TemperatureLoad event,
    Emitter<TemperatureState> emit,
  ) async {
    emit(TemperatureLoadInProgress());
    try {
      final response = await dio.get('');
      talker.info('Получен ответ: ${response.data}');
      final content = TemperatureContent.fromJson(response.data);
      emit(TemperatureLoadSuccess(content: content));
    } catch (e, st) {
      talker.error('Ошибка загрузки данных температуры', e, st);
      emit(TemperatureLoadFailure(exception: e));
    }
  }
}