import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future addToList(String station) async {
    print("ok");
    SharedPreferences prefs = await _getSharedPreference();

    var savedStations = await selectSavedStation();


    if (savedStations != null && savedStations.isNotEmpty) {
      print(station);
      var existsStation = savedStations.any((x) => x == station.trim());

      if (!existsStation) {
        print(station);
        savedStations.add(station);
        _saveLocal(prefs, savedStations);
      }
    } else {
      print(station);
      var savedStations = List<String>();
      savedStations.add(station);
      _saveLocal(prefs, savedStations);

    }
  }

  Future<List<String>> selectSavedStation() async {
    SharedPreferences prefs = await _getSharedPreference();
    print('yes');
    return prefs.getStringList('savedStations');
  }

  Future deleteSavedStation(int index) async {
    SharedPreferences prefs = await _getSharedPreference();
    var list = await selectSavedStation();
    list.removeAt(index);
    _saveLocal(prefs, list);
  }

  void _saveLocal(SharedPreferences prefs, List<String> list) {
    prefs.setStringList('savedStations', list);
    print('ok');
  }

  Future<Map<String, dynamic>> selectGeoBusStation(String shortName) async {
    String busStationsJson = await rootBundle.loadString('assets/locations/BusStations.json');

    List<dynamic> busStations = json.decode(busStationsJson);

    return busStations.singleWhere((element) {
      return element["short_name"] == shortName;
    });
  }

  Future<SharedPreferences> _getSharedPreference() async {
    return await _prefs;
  }
}
