import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gtbuddy/models/savedStations.dart';
import 'package:gtbuddy/models/busLive.dart';
import 'package:http/http.dart';

class LocationApiProvider {

  Client client = Client();
  final _command = '?cmd=getLiveBusData&for=pretoria';
  final _baseUrl = "http://www.mdits.co.za/gtbuddy/";


  Future<List<SavedStations>> fetchLocationList(BuildContext context) async {
    final jsonLocations = await DefaultAssetBundle.of(context)
        .loadString('assets/locations/BusStations.json');
    print(jsonLocations);
    print("hello");
    List<dynamic> mapJsonLocations = jsonDecode(jsonLocations);
    print(mapJsonLocations);

    List<SavedStations> mySavedStations = List<SavedStations>();
        mapJsonLocations.forEach((data)
        {
          SavedStations stations = SavedStations.fromJson(data);
          mySavedStations.add(stations);


        }
    );



    return mySavedStations;





    }

  Future<LiveBus> fetchLive(int busId) async {
    final response =
    await client.get("$_baseUrl/$_command");

    if (response.statusCode == 200) {
      return LiveBus.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load live buses');
    }
  }






  }



