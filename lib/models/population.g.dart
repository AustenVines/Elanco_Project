// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'population.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityPopulation _$CityPopulationFromJson(Map<String, dynamic> json) =>
    CityPopulation(
      city: json['city'] as String?,
      country: json['country'] as String?,
      populationCounts: json['populationCounts'] as List<dynamic>?,
    );

Map<String, dynamic> _$CityPopulationToJson(CityPopulation instance) =>
    <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
      'populationCounts': instance.populationCounts,
    };
