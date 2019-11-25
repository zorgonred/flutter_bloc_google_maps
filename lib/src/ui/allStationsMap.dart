import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gtbuddy/src/models/routes.dart';
import 'package:gtbuddy/src/ui/components/serviceArea.dart';

class MapSample extends StatefulWidget {
  final String selectedStation;

  MapSample({this.selectedStation});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  GoogleMapController _controller;

  Future<String> loadMyCoord() async {
    var x = await rootBundle
        .loadString('assets/busStops/AllBusStop${widget.selectedStation}.json');
    return x;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Routes"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 62, 64, 1),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => busStationList()),
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: loadMyCoord(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              List<dynamic> parsedJson = jsonDecode(snapshot.data);

              List<Marker> allMarkersByPosition = [];

              parsedJson.forEach((element){
                List<dynamic> coords = element["bs"];

                coords.forEach((i) {
                  double lat = double.tryParse(i["la"]);
                  double lng = double.tryParse(i["lo"]);

                  allMarkersByPosition.add(Marker(
                      markerId: MarkerId('location_${i["tts"]}'),
                      position: LatLng(lat ?? 0.0, lng ?? 0.0)));
                }

                );
              });



              return GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: LatLng(30.5595, 22.9375), zoom: 1.0),
                markers: Set.from(allMarkersByPosition),
                onMapCreated: mapCreated,
              );
            },
          ),
        ),
      ]),
    );
  }

//      body: Stack(children: [
//        Container(
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
//          child: FutureBuilder(
//            future: _future,
//            builder: (context, AsyncSnapshot snapshot) {
//              if (!snapshot.hasData) {
//                return CircularProgressIndicator();
//              }
//
//
//              List<Routes> parsedJson = jsonDecode(snapshot.data);
//
//
//              allMarkers = parsedJson.map((element) {
//
//                element.coords.forEach((internalItem){
//                  print(internalItem.latitude);
//                  return Marker(
//                    //here you need to create a random name.
//
//                      markerId: MarkerId(internalItem.iD),
//                      position: LatLng(internalItem.latitude, internalItem.longitude));
//                });
//
//
//              }).toList();
//
//              return GoogleMap(
//                initialCameraPosition: CameraPosition(
//                    target: LatLng(-26.0000, 28.0000), zoom: 10.151926040649414),
//                markers: Set.from(allMarkers),
//                onMapCreated: mapCreated,
//              );
//            },
//          ),
//        ),
//      ]),
//    );
//  }
  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}
