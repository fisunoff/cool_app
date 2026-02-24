import 'package:flutter/material.dart';
import '../../widgets/temperature_content.dart';

class TemperatureDetailScreen extends StatelessWidget {
  final TemperatureContent content;
  final int index;

  const TemperatureDetailScreen({
    super.key,
    required this.content,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final temperatureData = content.list?[index];
    final cityName = content.city?.name ?? 'Неизвестный город';
    final temp = temperatureData?.main?.temp;
    final feelsLike = temperatureData?.main?.feelsLike;
    final tempMin = temperatureData?.main?.tempMin;
    final tempMax = temperatureData?.main?.tempMax;
    final pressure = temperatureData?.main?.pressure;
    final humidity = temperatureData?.main?.humidity;
    final weatherDescription = temperatureData?.weather?.first.description ?? '';
    final weatherMain = temperatureData?.weather?.first.main ?? '';
    final dateTime = _formatDateTime(temperatureData?.dt, temperatureData?.dtTxt);

    return Scaffold(
      appBar: AppBar(
        title: Text('Детали температуры'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Город и дата
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cityName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dateTime,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Основная температура
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.thermostat,
                          size: 48,
                          color: _getTempColor(temp),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          _formatTemperature(temp),
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: _getTempColor(temp),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (weatherMain.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        weatherMain,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                    if (weatherDescription.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        weatherDescription,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Детальная информация
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDetailRow(
                      context,
                      'Ощущается как',
                      _formatTemperature(feelsLike),
                      Icons.thermostat_outlined,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      context,
                      'Минимум',
                      _formatTemperature(tempMin),
                      Icons.arrow_downward,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      context,
                      'Максимум',
                      _formatTemperature(tempMax),
                      Icons.arrow_upward,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      context,
                      'Давление',
                      pressure != null ? '$pressure гПа' : 'Н/Д',
                      Icons.speed,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      context,
                      'Влажность',
                      humidity != null ? '$humidity%' : 'Н/Д',
                      Icons.water_drop,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTemperature(double? temp) {
    if (temp == null) return 'Н/Д';
    return '${temp.toStringAsFixed(1)}°C';
  }

  String _formatDateTime(int? dt, String? dtTxt) {
    if (dtTxt != null) {
      try {
        final date = DateTime.parse(dtTxt);
        return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${date.hour.toString().padLeft(2, '0')}:00';
      } catch (e) {
        return dtTxt;
      }
    }
    
    if (dt != null) {
      try {
        final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
        return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      } catch (e) {
        return 'Неизвестная дата';
      }
    }
    
    return 'Дата неизвестна';
  }

  Color _getTempColor(double? temp) {
    if (temp == null) return Colors.grey;
    if (temp < -20) return Colors.purple;
    if (temp < -10) return Colors.indigo;
    if (temp < 0) return Colors.lightBlue;
    if (temp < 10) return Colors.blue;
    if (temp < 15) return Colors.lightGreen;
    if (temp < 20) return Colors.green;
    if (temp < 25) return Colors.orange;
    if (temp < 30) return Colors.deepOrange;
    if (temp < 35) return Colors.red;
    return Colors.deepPurple;
  }
}