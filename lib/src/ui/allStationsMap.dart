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
  Future _future;

  Future<String> loadString() async =>
//      await rootBundle.loadString('assets/Routes/coords_${widget.selectedStation}.json');
  await rootBundle.loadString('assets/route/coords_${widget.selectedStation}.json');
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


              List<Routes> parsedJson = jsonDecode(snapshot.data);


              allMarkers = parsedJson.map((element) {

                element.coords.forEach((internalItem){
                  return Marker(
                    //here you need to create a random name.

                      markerId: MarkerId(internalItem.iD),
                      position: LatLng(internalItem.latitude, internalItem.longitude));
                });


              }).toList();

              return GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(-26.0000, 28.0000), zoom: 10.151926040649414),
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
