import 'package:json_annotation/json_annotation.dart';

part 'population.g.dart';


@JsonSerializable()
class CityPopulation {
  final String? city;
  final String? country;
  final List? populationCounts;

  CityPopulation({
    this.city,
    this.country,
    this.populationCounts,
  });

  factory CityPopulation.fromJson(Map<String, dynamic> json) =>
      _$CityPopulationFromJson(json);

  Map<String, dynamic> toJson() => _$CityPopulationToJson(this);

// Helper method to get the latest population value

}