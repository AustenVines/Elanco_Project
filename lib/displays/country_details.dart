import 'package:flutter/material.dart';

import '../models/country.dart';
import '../models/population.dart';


class CountryDetails extends StatelessWidget {
  final Country country;
  final List<CityPopulation> populationData;

  CountryDetails({required this.country, required this.populationData});

  @override
  Widget build(BuildContext context) {
    // Filter the cities based on the selected country
    final cities = populationData
        .where((city) => city.country == country.name)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(country.name ?? 'Country Details'),
      ),
      body: cities.isEmpty
          ? Center(
        child: Text('No city data available for ${country.name}.'),
      )
          : ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          final populationCounts = city.populationCounts;

          return ListTile(
            title: Text(city.city ?? 'Unknown City'),
            subtitle: populationCounts != null && populationCounts.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var population in populationCounts)
                  Text('Year: ${population['year']}, Population: ${population['value']}')
              ],
            )
                : Text('No population data available'),
          );
        },
      ),
    );
  }
}
