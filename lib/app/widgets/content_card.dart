import 'package:flutter/material.dart';
import 'temperature_content.dart';
import '../features/home/temperature_detail_screen.dart';

class ContentCard extends StatelessWidget {
  final TemperatureContent content;
  final int index;

  const ContentCard({
    super.key,
    required this.content,
    required this.index,
  });
  
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

  String _getTemperature(double? temp) {
    if (temp == null) return 'Температура неизвестна';
    return '${temp.toStringAsFixed(1)}°C';
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

  String _getWeatherDescription(List<dynamic>? weather) {
    if (weather == null || weather.isEmpty) return '';
    try {
      return (weather.first as Map)['description'] ?? '';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = 100.0;
    final temperatureData = content.list != null && index < content.list!.length 
      ? content.list![index] 
      : null;
    final temp = temperatureData?.main?.temp;
    final feelsLike = temperatureData?.main?.feelsLike;
    final cityName = content.city?.name ?? 'Неизвестный город';
    final weatherDescription = _getWeatherDescription(temperatureData?.weather);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          // Навигация на экран детализации
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TemperatureDetailScreen(
                content: content,
                index: index,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: imageSize,
            child: Row(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: imageSize,
                    width: imageSize,
                    color: _getTempColor(temp).withOpacity(0.2),
                    child: Center(
                      child: Text(
                        _getTemperature(temp),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _getTempColor(temp),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _getTemperature(temp),
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: _getTempColor(temp),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              cityName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      if (feelsLike != null)
                        Text(
                          'Ощущается как: ${feelsLike.toStringAsFixed(1)}°C',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      if (weatherDescription.isNotEmpty)
                        Text(
                          weatherDescription,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          _formatDateTime(temperatureData?.dt, temperatureData?.dtTxt),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}