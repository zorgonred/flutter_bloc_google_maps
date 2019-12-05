import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gtbuddy/models/busLive.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MapTWo extends StatefulWidget {
  final String selectStation;

  final String selectCoords;

  final String appBar;

  var initialLat;
  var initialLong;

  MapTWo(
      {this.selectStation,
        this.selectCoords,
        this.appBar,
        this.initialLat,
        this.initialLong});

  @override
  _MapTWoState createState() => _MapTWoState();
}

class _MapTWoState extends State<MapTWo> {
  //custom bus icons
  BitmapDescriptor customIcon;

  BitmapDescriptor custoIcon;

  StreamSubscription live;

  loadMyStations() async {
    var stringJson =
    await rootBundle.loadString('assets/bus_stops/AllBusStops.json');
    var parsedJson = json.decode(stringJson);
    List listStations = parsedJson['Result']['routes'][0]['bs'];
    var stationsEncode = json.encode(listStations);
    return stationsEncode;
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
          configuration, 'assets/icons/bus_stop/bus_stop@2x.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  createMarkerr(context) {
    if (custoIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
          configuration, 'assets/icons/live_bus/bus_position@2x.png')
          .then((icon) {
        setState(() {
          custoIcon = icon;
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

  Future<String> loadString() async {
    if (widget.selectStation != 'All') {
      return await rootBundle
          .loadString('assets/bus_stops/stops_${widget.selectStation}.json');
    } else {
      var stations = await loadMyStations();
      return stations;
    }
  }

  List<Marker> allMarkers = <Marker>[];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController _controller;

  //future 2

  Future <String> loadMyCoord() async {
    if (widget.selectStation != 'All') {
      var x = await rootBundle.loadString(
          'assets/routes_strings/coords_${widget.selectStation}.json');

      print('Hello: ${widget.selectStation}');
      return x;
    } else {
      var x = await rootBundle
          .loadString('assets/routes_strings/coords_${widget.selectStation}.json');
      return x;
    }
  }

  //future 3

  Client client = Client();
  final _command = '?cmd=getLiveBusData&for=';
  final _baseUrl = "http://www.mdits.co.za/gtbuddy/";

  Future<LiveBus> fetchLive() async {
    final response = await http.get("$_baseUrl/$_command${widget.selectStation.toLowerCase()}");
    print(response);
    var jsonData = json.decode(response.body);
    print("printed3");
    return LiveBus.fromJson(jsonData);
  }

  @override
  void dispose() {
    super.dispose();
    live.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //future 1
    _future = loadString();

    //future 2
    _futuree = loadMyCoord();

    //future 3

    _fuuture = fetchLive();

    live = Stream.periodic(Duration(seconds: 5)).listen((data) async {
      LiveBus Jsonparsed = await fetchLive();
      print("printed4");
      Jsonparsed.result.busPositions.forEach((f) {
        final MarkerId markerId = MarkerId(f.busId);

        final Marker marker = Marker(
          markerId: markerId,
          icon: custoIcon,
          position: LatLng(f.latitude ?? 0.0, f.longitude ?? 0.0),
          onTap: () {},
        );

        setState(() {
          markers[markerId] = marker;
        });
      });
    });
  }


  static const LatLng _center = const LatLng(33.738045, 73.084488);
  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    createMarkerr(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.appBar}'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, false),
        ),
        backgroundColor: Color.fromRGBO(59, 62, 64, 1),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            textColor: Colors.white,
            child: Text(
              "Nearest",
              style: TextStyle(color: Colors.white),
            ),
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

              _fuuture
            ]),

            builder: (
                context,
                AsyncSnapshot<List> snapshot,
                ) {
              // Check hasData once for all futures.
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              print("something");
              //future [0]

              List<dynamic> parsedJson = jsonDecode(snapshot.data[0]);

//              allMarkers = parsedJson.map((element) {
//                return widget.selectStation != 'All'
//                    ? Marker(
//                    icon: customIcon,
//                    markerId: MarkerId(element["Latitude"].toString()),
//                    position: LatLng(element['Latitude'] ?? 0.0,
//                        element['Longitude'] ?? 0.0))
//                    : Marker(
//                    icon: customIcon,
//                    markerId: MarkerId(element["la"].toString()),
//                    position:
//                    LatLng(element['la'] ?? 0.0, element['lo'] ?? 0.0));
//              }).toList();

              //future [1]

              parsedJson.forEach((element) {
                final MarkerId markerId = MarkerId('${element['StopNumber']}_future_1');

                final Marker marker = Marker(
                  markerId: markerId,
                  icon: customIcon,
                  position: LatLng(
                      element['Latitude'] ?? 0.0, element['Longitude'] ?? 0.0),
                  onTap: () {},
                );

                markers[markerId] = marker;
              });

              List<dynamic> parseJson = jsonDecode(snapshot.data[1]);

              Set<Polyline> allPolylinesByPosition = {};

              parseJson.forEach((element) {
                String coordsString = element["coords"];
                String color =
                widget.selectStation != 'All' ? element["colour"] : null;

                List<Map<String, String>> coords = [];

                //..//
                String lat = '';
                String long = '';
                bool isLat = true;

                for (int i = 0; i < coordsString.length; i++) {
                  if (coordsString[i] != ',' && coordsString[i] != '~') {
                    isLat ? lat += coordsString[i] : long += coordsString[i];
                  } else {
                    if (coordsString[i] == ',') {
                      isLat = false;
                    } else {
                      isLat = true;
                      coords.add({'latitude': lat, "longitude": long});
                      lat = '';
                      long = '';
                    }
                  }
                }
                //..//

                List<LatLng> latlng = [];
                if (widget.selectStation != 'All') {
                  coords.forEach((i) {
                    latlng.add(LatLng(double.tryParse(i["latitude"] ?? 0.0),
                        double.tryParse(i["longitude"] ?? 0.0)));

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
                }
              });

              //future [2]
              LiveBus Jsonparsed = snapshot.data[2];

              Jsonparsed.result.busPositions.forEach((f) {
                final MarkerId markerId = MarkerId('${f.busId}_future_2');

                final Marker marker = Marker(
                  markerId: markerId,
                  icon: custoIcon,
                  position: LatLng(f.latitude ?? 0.0, f.longitude ?? 0.0),
                  onTap: () {},
                );

                markers[markerId] = marker;
              });

              return GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: widget.selectStation != 'All'
                        ? LatLng(
                      widget.initialLat,
                      widget.initialLong,
                    )
                        : LatLng(
                      -25.851942,
                      28.189608,
                    ),
                    zoom: 8.0),
                markers: Set<Marker>.of(markers.values),
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
