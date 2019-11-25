import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gtbuddy/src/models/routes.dart';
import 'package:gtbuddy/src/ui/components/serviceArea.dart';


class MapTWo extends StatefulWidget {

  final String selectStation;

  MapTWo({this.selectStation});

  @override
  _MapTWoState createState() => _MapTWoState();
}

class _MapTWoState extends State<MapTWo> {


  Future _future;

  Future<String> loadString() async =>
      await rootBundle.
      loadString('assets/busStops/stops_${widget.selectStation}.json');
  List<Marker> allMarkers = [];
  GoogleMapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = loadString();
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
            future: _future,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              List<dynamic> parsedJson = jsonDecode(snapshot.data);
              allMarkers = parsedJson.map((element) {
                return Marker(
                    markerId: MarkerId(element["StopNumber"].toString()),
                    position: LatLng(element['Latitude']?? 0.0, element['Longitude']?? 0.0));
              }).toList();

              return GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(-26.1711459, 27.9002758), zoom: 9.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
              );
            },
          ),
        ),
      ]),
    );
  }


  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }


}
