//SvgPicture.network("https://upload.wikimedia.org/wikipedia/commons/3/36/Flag_of_Albania.svg")

import 'package:flutter/material.dart'; // Required for the Image widget
import 'package:json_annotation/json_annotation.dart';

part 'flags.g.dart';

@JsonSerializable()
class CountryFlag {
  final String? name;
  final String? flag;
  final String? iso2;
  final String? iso3;

  CountryFlag({
    this.name,
    this.flag,
    this.iso2,
    this.iso3
  });

  factory CountryFlag.fromJson(Map<String, dynamic> json) =>
      _$CountryFlagFromJson(json);

  Map<String, dynamic> toJson() => _$CountryFlagToJson(this);

  /// Returns an `Image` widget for the flag URL.


}
