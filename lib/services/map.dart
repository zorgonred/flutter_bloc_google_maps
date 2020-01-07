import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:gtbuddy/models/map_bus_live.dart';

class MapLocations {
  final _command = '?cmd=getLiveBusData&for=';
  final _baseUrl = "http://www.mdits.co.za/gtbuddy/";

  loadMyStations() async {
    var stringJson = await rootBundle.loadString('assets/bus_stops/AllBusStops.json');
    var parsedJson = json.decode(stringJson);
    List listStations = parsedJson['Result']['routes'][0]['bs'];
    var stationsEncode = json.encode(listStations);
    return stationsEncode;
  }

  Future<String> loadBusStopsBySelectedStation(selectStation) async {
    if (selectStation != 'All') return await rootBundle.loadString('assets/bus_stops/stops_${selectStation}.json');
    return await loadMyStations();
  }

  Future<String> loadRoutesBySelectedStation(selectStation) async {
    if (selectStation != 'All') return await rootBundle.loadString('assets/routes_strings/coords_${selectStation}.json');
    return await rootBundle.loadString('assets/bus_stops/AllBusStops.json');
  }

  Future<LiveBus> liveBusStatisonFromAPI(selectStation) async {
    final response = await http.get("$_baseUrl/$_command${selectStation.toLowerCase()}");
    return LiveBus.fromJson(json.decode(response.body));
  }
}
