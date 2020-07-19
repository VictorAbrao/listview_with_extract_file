// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//Autor: Victor Hugo Liboni Abrão

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Lista de Cidades em São Paulo',
      home: GetCities(),

    );
  }
}




class GetCities extends StatefulWidget {
  @override
  GetCitiesSP createState() => GetCitiesSP();
}

class GetCitiesSP extends State<GetCities> {
  @override
  List<String> _cities = [];
  final _biggerFont = TextStyle(fontSize: 18.0);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Cidades de São Paulo'),
      ),
      body: _buildSuggestions(),
    );
  }

  //Extracting cities from the txt file
  Future<List<String>> loadCities() async {
    List<String> cities = [];
    await rootBundle.loadString('assets/cities.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        cities.add(i);
      }
    });
    return cities;
  }

  _setup() async {
    // Retrieve the cities (Processed in the background)
    List<String> cities = await loadCities();

    // Notify the UI and display the cities
    setState(() {
      _cities = cities;
    });
  }

  Widget _buildSuggestions() {
    List<String> _listCity = new List();
    _setup();
    _listCity = _cities;

    //Building List View
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _listCity.length*2,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/
          final index = i ~/ 2; /*3*/
          return _buildRow(_listCity[index]);
        });
  }

  Widget _buildRow(String pair) {
    //Building List Item
    return ListTile(
      title: Text(
        pair,
        style: _biggerFont,
      ),
    );
  }

}



