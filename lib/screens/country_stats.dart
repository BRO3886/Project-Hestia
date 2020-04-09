import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_hestia/model/country_data_stats.dart';
import 'package:project_hestia/model/util.dart';

class CountryStatisticsScreen extends StatefulWidget {
  @override
  _CountryStatisticsScreenState createState() =>
      _CountryStatisticsScreenState();
}

class _CountryStatisticsScreenState extends State<CountryStatisticsScreen> {
  String selectedRegion;
  Future<List<String>> getCountries() async {
    List<String> countries = [];
    final String url = "http://hestia-info.herokuapp.com/allCountries";
    try {
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> resBody = json.decode(response.body);
        // print(resBody);
        countries = resBody["allCountries"].cast<String>();
        countries = countries.map((country) => country).toList();
        countries.sort((a, b) => a.compareTo(b));
        // print(countries);
        selectedRegion = countries[0];
      }
      return countries;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<CountryData> getStatsforcountry(String country) async {
    final url = "http://hestia-info.herokuapp.com/allCountriesData/$country";
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        CountryData countryData = countryDataFromJson(response.body);
        return countryData;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCountries(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<String> countries = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: colorWhite,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 0,
                          // color: Colors.grey[600].withOpacity(0.1),
                          color: Color(0x23000000),
                        ),
                      ]),
                  height: 50,
                  padding: EdgeInsets.all(10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text('Select Country'),
                      value: selectedRegion,
                      isDense: true,
                      onChanged: (value) {
                        setState(() {
                          selectedRegion = value;
                        });
                        print(selectedRegion);
                      },
                      items: countries.map((String country) {
                        return DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: getStatsforcountry(selectedRegion),
                  builder: (ctx, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else{
                      CountryData countryData = snapshot.data;
                      print(countryData.countryData.deaths);
                      return Text(countryData.countryData.deaths.toString());
                    }
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
