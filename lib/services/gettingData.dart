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

Future<String> fetchFlag(String country) async {
  var url = 'https://countriesnow.space/api/v0.1/countries/flag/images/q?country=' + country;
  // print(url);

  final response = await http.get(Uri.parse(url),
  );

  if (response.statusCode >= 200) {
    final data = json.decode(response.body);
    // print(data['data']['flag']);
    return data['data']['flag'];
  } else {

    throw Exception('Failed to load countries and capitals');

  }
}

// void main()  {
//   fetchFlag("Albania");
// }
