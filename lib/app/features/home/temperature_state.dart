part of 'temperature_bloc.dart';

abstract class TemperatureState {}

class TemperatureInitial extends TemperatureState {}

class TemperatureLoadInProgress extends TemperatureState {}

class TemperatureLoadSuccess extends TemperatureState {
  final TemperatureContent content;
  TemperatureLoadSuccess({required this.content});
}

class TemperatureLoadFailure extends TemperatureState {
  final Object exception;
  TemperatureLoadFailure({required this.exception});
}