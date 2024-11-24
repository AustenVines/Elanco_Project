import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';
import '../models/population.dart';

Future<List<Country>> fetchCountriesAndCapitals() async {
  const url = 'https://countriesnow.space/api/v0.1/countries/capital';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    final countryList = data['data'] as List<dynamic>;
    // print(countryList[0]['name']);
    return countryList.map((json) => Country.fromJson(json)).toList();
  } else {

    throw Exception('Failed to load countries and capitals');

  }
}


Future<List<CityPopulation>> fetchCitiesAndPopulation() async {
  const url = 'https://countriesnow.space/api/v0.1/countries/population/cities';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    final cityList = data['data'] as List<dynamic>;
    return cityList.map((json) => CityPopulation.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load city populations');
  }
}

void main() {
    // final cityPopulation = await fetchCitiesAndPopulation();
    // var one = cityPopulation[0].populationCounts;
    // print(one?[0]);
    // for (var city in cityPopulation) {
    //   final populations = city.getPopulation();
    //   for (var pop in populations) {
    //     print('Population: $pop');


}
