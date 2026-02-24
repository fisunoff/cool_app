class TemperatureContent {
  final String? id;
  final List<TemperatureData>? list;
  final City? city;

  TemperatureContent({
    this.id,
    this.list,
    this.city,
  });

  factory TemperatureContent.fromJson(Map<String, dynamic> json) {
    return TemperatureContent(
      list: json['list'] != null
          ? (json['list'] as List)
              .map((item) => TemperatureData.fromJson(item))
              .toList()
          : null,
      city: json['city'] != null ? City.fromJson(json['city']) : null,
    );
  }
}

class TemperatureData {
  final MainData? main;
  final int? dt;
  final String? dtTxt; // Добавлено для forecast API
  final List<Weather>? weather;

  TemperatureData({
    this.main,
    this.dt,
    this.dtTxt,
    this.weather,
  });

  factory TemperatureData.fromJson(Map<String, dynamic> json) {
    return TemperatureData(
      main: json['main'] != null ? MainData.fromJson(json['main']) : null,
      dt: json['dt'],
      dtTxt: json['dt_txt'],
      weather: json['weather'] != null
          ? (json['weather'] as List)
              .map((w) => Weather.fromJson(w))
              .toList()
          : null,
    );
  }
}

class MainData {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;

  MainData({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  factory MainData.fromJson(Map<String, dynamic> json) {
    return MainData(
      temp: json['temp']?.toDouble(),
      feelsLike: json['feels_like']?.toDouble(),
      tempMin: json['temp_min']?.toDouble(),
      tempMax: json['temp_max']?.toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}

class Weather {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class City {
  final int? id;
  final String? name;
  final Coord? coord;
  final String? country;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      country: json['country'],
    );
  }
}

class Coord {
  final double? lat;
  final double? lon;

  Coord({
    this.lat,
    this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat']?.toDouble(),
      lon: json['lon']?.toDouble(),
    );
  }
}