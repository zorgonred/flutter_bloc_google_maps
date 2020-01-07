import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future addToList(String station) async {
    SharedPreferences prefs = await _getSharedPreference();

    var savedStations = await selectSavedStation();

    if (savedStations.isNotEmpty) {
      var existsStation = savedStations.any((x) => x == station.trim());

      if (!existsStation) {
        savedStations.add(station);
        _saveLocal(prefs, savedStations);
      }
    } else {
      _saveLocal(prefs, [station]);
    }
  }

  Future<List<String>> selectSavedStation() async {
    SharedPreferences prefs = await _getSharedPreference();
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
