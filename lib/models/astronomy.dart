
class AstronomyModel {
  final Location location;
  final Astronomy astronomy;

  AstronomyModel({required this.astronomy, required this.location});

  factory AstronomyModel.fromJson(Map<String, dynamic> json) => AstronomyModel(
        location: Location(
          name: json['location']['name'],
          region: json['location']['region'],
        ),
        astronomy: Astronomy(astro: Astro.fromJson(json['astronomy']['astro'])),
      );
}

class Location {
  final String name;
  final String region;

  Location({required this.name, required this.region});
}

class Astronomy {
  final Astro astro;

  Astronomy({required this.astro});
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;

  Astro(
      {required this.sunrise,
      required this.sunset,
      required this.moonrise,
      required this.moonset});

  factory Astro.fromJson(Map<String, dynamic> data) => Astro(
        sunrise: data['sunrise'],
        sunset: data['sunset'],
        moonrise: data['moonrise'],
        moonset: data['moonset'],
      );
}
