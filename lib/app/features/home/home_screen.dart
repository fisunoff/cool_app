import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../widgets/app_error.dart';
import '../../widgets/app_progress_indicator.dart';
import '../../widgets/content_card.dart';
import 'temperature_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _temperatureBloc = GetIt.I<TemperatureBloc>();
  void loadTemperature() => _temperatureBloc.add(TemperatureLoad());

  @override
  void initState() {
    loadTemperature();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История температуры'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<TemperatureBloc, TemperatureState>(
        bloc: _temperatureBloc,
        builder: (context, state) {
          return switch (state) {
            TemperatureInitial() => _buildTemperatureInitial(),
            TemperatureLoadInProgress() => _buildTemperatureLoadInProgress(),
            TemperatureLoadSuccess() => _buildTemperatureLoadSuccess(state),
            TemperatureLoadFailure() => _buildTemperatureLoadFailure(state),
            _ => const Center(child: Text('Неизвестное состояние')), // wildcard pattern
          };
        },
      ),
    );
  }

  Widget _buildTemperatureInitial() => const SizedBox.shrink();

  Widget _buildTemperatureLoadInProgress() => const AppProgressIndicator();

  Widget _buildTemperatureLoadSuccess(TemperatureLoadSuccess state) {
    final content = state.content;

    if (content.list == null || content.list!.isEmpty) {
      return const Center(
        child: Text('Нет данных о температуре'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'История температуры',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          if (content.city != null)
            Text(
              'Город: ${content.city!.name ?? 'Неизвестно'}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          Text(
            'Найдено записей: ${content.list!.length}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: content.list!.length,
            itemBuilder: (_, index) => ContentCard(
              content: content,
              index: index,
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureLoadFailure(TemperatureLoadFailure state) {
    return AppError(
      description: state.exception.toString(),
      onTap: () => loadTemperature(),
    );
  }
}
