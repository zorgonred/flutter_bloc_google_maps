import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class MapTWo extends StatefulWidget {
  final String selectStation;

  final String selectCoords;

  MapTWo({this.selectStation, this.selectCoords});

  @override
  _MapTWoState createState() => _MapTWoState();
}

class _MapTWoState extends State<MapTWo> {
  //custom bus icons
  BitmapDescriptor customIcon;

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/icons/bus_stop/bus_stop@2x.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  //future 1
  Future _future;

  //future 2

  Future _futuree;

  //future 3

  Future _fuuture;

  //future 1



  Future<String> loadString() async => await rootBundle
      .loadString('assets/bus_stops/stops_${widget.selectStation}.json');
  List<Marker> allMarkers = [];
  GoogleMapController _controller;

  //future 2


  Future<String> loadMyCoord() async {
    var x = await rootBundle.loadString('assets/routes_refactored/coords_${widget.selectStation}.json');
    return x;
  }

  //future 3

//  Future<Map> getLiveBus() async {
//    var res = await http.get(
//        "");
//    return json.decode(res.body);
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //future 1
    _future = loadString();

    //future 2
    _futuree = loadMyCoord();

    //future 3

//    _fuuture = getLiveBus();
  }

  static const LatLng _center = const LatLng(33.738045, 73.084488);
  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Routes"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 62, 64, 1),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => busStationList()),
//              );
//            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            //futures
            future: Future.wait([
              //[0]
              _future,

              //[1]
              _futuree,

              //[2]

//              _fuuture
            ]),

            builder: (
                context,
                AsyncSnapshot<List> snapshot,
                ) {
              // Check hasData once for all futures.
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              //future [0]

              List<dynamic> parsedJson = jsonDecode(snapshot.data[0]);




              allMarkers = parsedJson.map((element) {
                return Marker(
                    icon: customIcon,
                    markerId: MarkerId(element["Latitude"].toString()),
                    position: LatLng(element['Latitude'] ?? 0.0,
                        element['Longitude'] ?? 0.0));
              }).toList();


              //future [1]

              List<dynamic> parseJson = jsonDecode(snapshot.data[1]);

              Set<Polyline> allPolylinesByPosition = {};

              parseJson.forEach((element) {
                List<dynamic> coords = element["coords"];
                String color = element["colour"];

                List<LatLng> latlng = [];

                coords.forEach((i) {


                  latlng.add(LatLng(double.tryParse(i["latitude"]?? 0.0) ,
                      double.tryParse(i["longitude"]?? 0.0) ));

                  hexToColor(String code) {
                    String hash = "#";
                    hash += code;
                    return new Color(
                        int.parse(hash.substring(1, 7), radix: 16) +
                            0xFF000000);
                  }

                  allPolylinesByPosition.add(
                    Polyline(
                      polylineId: PolylineId((_lastMapPosition.toString())),
                      points: latlng,
                      visible: true,
                      width: 4,
                      color: hexToColor(color),
                    ),
                  );
                  print(PolylineId);
                });
              });


              //future [2]

//              List<dynamic> Jsonparsed = jsonDecode(snapshot.data[2]);
//
//
//
//              //add to same list??
//              allMarkers = Jsonparsed.map((element) {
//                return Marker(
//                    icon: customIcon,
//                    markerId: MarkerId(element["Latitude"].toString()),
//                    position: LatLng(element['Latitude'] ?? 0.0,
//                        element['Longitude'] ?? 0.0));
//              }).toList();



              return GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(-26.1711459, 27.9002758), zoom: 10.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
                polylines: allPolylinesByPosition,
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
