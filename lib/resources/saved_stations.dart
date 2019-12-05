import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gtbuddy/blocs/dashboard/dashboard_bloc.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_pattern/bloc_pattern.dart';


class SavedService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();



  Future addtoList(String station) async {

    final SharedPreferences prefs = await _prefs;
    var list = await selectSavedStation();

    if (list != null && list.length > 0) {
      print("length of list" + list.length.toString());
      var existsStation = list.any((x) => x == station.trim());
      print(existsStation);
      if (!existsStation) {
        list.add(station);
        prefs.setStringList('savedStations', list);
        print('added item');

      }
    } else {
      var x = List<String>();
      x.add(station);
      prefs.setStringList('savedStations', x);
      print('added first item');

    }
  }

  Future<List<String>> selectSavedStation() async {
    final SharedPreferences prefs = await _prefs;
    var name = prefs.getStringList('savedStations');

    if (name == null) {
      return null;
    }
    ;
    print(name.length);
    return name;
  }

  Future deleteFromDashboard(int index) async {
    final SharedPreferences prefs = await _prefs;
    var list = await selectSavedStation();
    list.removeAt(index);
    prefs.setStringList('savedStations', list);

  }



}
