class ForecastModel {
  late int dt;
  late Main main;
  late List<Weather> weather;
  late Clouds clouds;
  late Wind wind;
  late int visibility;
  late double pop;
  late Sys sys;
  late DateTime dtTxt;

  ForecastModel({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  ForecastModel.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = Main.fromJson(json['main']);
    weather = List<Weather>.from(
        json['weather'].map((weatherItem) => Weather.fromJson(weatherItem)));
    clouds = Clouds.fromJson(json['clouds']);
    wind = Wind.fromJson(json['wind']);
    visibility = json['visibility'];
    pop = json['pop'].toDouble();
    sys = Sys.fromJson(json['sys']);
    dtTxt = DateTime.parse(json['dt_txt']);
  }
}

class Main {
  late double temp;
  late double feelsLike;
  late double tempMin;
  late double tempMax;
  late int pressure;
  late int seaLevel;
  late int grndLevel;
  late int humidity;
  late double tempKf;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    tempMin = json['temp_min'].toDouble();
    tempMax = json['temp_max'].toDouble();
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = json['temp_kf'].toDouble();
  }
}

class Weather {
  late int id;
  late String main;
  late String description;
  late String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Clouds {
  late int all;

  Clouds({
    required this.all,
  });

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class Wind {
  late double speed;
  late int deg;
  late double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'].toDouble();
    deg = json['deg'];
    gust = json['gust'].toDouble();
  }
}

class Sys {
  late String pod;

  Sys({
    required this.pod,
  });

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'];
  }
}
