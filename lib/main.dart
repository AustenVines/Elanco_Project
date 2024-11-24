import 'package:flutter/material.dart';

import 'displays/countryList.dart';
import 'services/gettingData.dart';
import 'models/country.dart';
import 'models/population.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Country>> _countries;
  late Future<List<CityPopulation>> _populationData;

  @override
  void initState() {
    super.initState();
    _countries = fetchCountriesAndCapitals();
    _populationData = fetchCitiesAndPopulation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Population App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Country Population Visualizer'),
        ),
        body: FutureBuilder<List<Country>>(
          future: _countries,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No countries found.'));
            }

            final countries = snapshot.data!;
            return FutureBuilder<List<CityPopulation>>(
              future: _populationData,
              builder: (context, popSnapshot) {
                if (popSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (popSnapshot.hasError) {
                  return Center(child: Text('Error: ${popSnapshot.error}'));
                } else if (!popSnapshot.hasData || popSnapshot.data!.isEmpty) {
                  return const Center(child: Text('No population data found.'));
                }

                final populationData = popSnapshot.data!;
                return CountryList(
                  countries: countries,
                  populationData: populationData,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
