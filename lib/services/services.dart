import 'dart:convert';

import 'package:flutter/services.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';



class SavedService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future addtoList(String station) async{
    final SharedPreferences prefs = await _prefs;
    var list = await selectSavedStation();
    if (list != null && list.length >0 ){
      list.add(station);
      prefs.setStringList('savedStations',list);



    }
    else {
      var x =  List<String>();
      x.add(station);
      prefs.setStringList('savedStations',x);


    }



  }

  Future<List<String>> selectSavedStation() async{


    final SharedPreferences prefs = await _prefs;
    var name = prefs.getStringList('savedStations');

    if (name == null){

      return null;
    };
    print(name.length);
    return name;


  }







}