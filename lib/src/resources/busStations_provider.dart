import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gtbuddy/src/models/busStations.dart';
import 'package:gtbuddy/src/ui/components/serviceArea.dart';

class MyAppp extends StatefulWidget {
  @override
  MyApppState createState() => new MyApppState();
}

class MyApppState extends State<MyAppp> {
  List data;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Select From"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(59, 62, 64, 1),
        ),
        body:
        Container(
          child:  Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child:  FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/locations/BusStations.json'),
                builder: (context, snapshot) {
                  List<BusStations> stations =
                      parseJosn(snapshot.data.toString());
                  return !stations.isEmpty
                      ?  busStationList(busStation: stations)
                      :  Center(child: new CircularProgressIndicator());
                }),
          ),
        ));
  }

  List<BusStations> parseJosn(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<BusStations>((json) => new BusStations.fromJson(json))
        .toList();
  }
}
