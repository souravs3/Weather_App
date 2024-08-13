class CityModel {
  final String name;
  final Map<String, String> localNames;
  final double lat;
  final double lon;
  final String country;
  final String state;

  CityModel({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'],
      localNames: Map<String, String>.from(json['local_names']),
      lat: json['lat'],
      lon: json['lon'],
      country: json['country'],
      state: json['state'],
    );
  }
}
