import 'package:elanco_api_project/services/gettingData.dart';
import 'package:flutter/material.dart';
import '../models/country.dart';
import '../models/population.dart';
import 'country_details.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryList extends StatefulWidget {
  final List<Country> countries;
  final List<CityPopulation> populationData;

  const CountryList({super.key, required this.countries, required this.populationData});

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late List<Country> _filteredCountries;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries; // Initially show all countries
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
      _filteredCountries = widget.countries
          .where((country) =>
      country.name != null &&
          country.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: _updateSearchQuery,
            decoration: const InputDecoration(
              labelText: 'Country search',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredCountries.length,
            itemBuilder: (context, index) {
              final country = _filteredCountries[index];

              return ListTile(
                title: Text(country.name ?? 'Unknown'),
                subtitle: Text(
                  'Capital: ${country.capital ?? 'N/A'}\n'
                      'ISO2: ${country.iso2 ?? 'N/A'} | ISO3: ${country.iso3 ?? 'N/A'}',
                ),
                trailing: FutureBuilder<String?>(
                  future: fetchFlag(country.name ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Show loading indicator
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return const Icon(Icons.error, color: Colors.red); // Show error icon
                    } else {
                      return SvgPicture.network(
                        snapshot.data!,
                        placeholderBuilder: (context) =>
                            const CircularProgressIndicator(),
                        height: 40,
                        width: 40,
                      );
                    }
                  },
                ),
                onTap: () {
                  // Navigate to the Country Details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CountryDetails(
                        country: country,
                        populationData: widget.populationData,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
