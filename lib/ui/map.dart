import 'dart:async';
import 'dart:convert';
import 'package:gtbuddy/models/map_bus_live.dart';
import 'package:gtbuddy/ui/tiles/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapLocations extends StatefulWidget {
  final String selectStation;
  final String selectCoords;
  final String appBar;
  var initialLat;
  var initialLong;

  MapLocations(
      {this.selectStation,
      this.selectCoords,
      this.appBar,
      this.initialLat,
      this.initialLong});

  @override
  _MapLocationsState createState() => _MapLocationsState();
}

class _MapLocationsState extends State<MapLocations> {
  BitmapDescriptor _customIconForBusStations;
  BitmapDescriptor _custoIconForLiveBus;
  StreamSubscription _liveBusStationsStream;
  GoogleMapController _controller;
  Future _futureBusStops;
  Future _futureRoutes;
  Future _futureLiveBus;
  List<Marker> allMarkers = <Marker>[];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final _command = '?cmd=getLiveBusData&for=';
  final _baseUrl = "http://www.mdits.co.za/gtbuddy/";
  static const LatLng _center = const LatLng(33.738045, 73.084488);
  LatLng _lastMapPosition = _center;

  loadMyStations() async {
    var stringJson =
        await rootBundle.loadString('assets/bus_stops/AllBusStops.json');
    var parsedJson = json.decode(stringJson);
    List listStations = parsedJson['Result']['routes'][0]['bs'];
    var stationsEncode = json.encode(listStations);
    return stationsEncode;
  }

  createMarkerForBusStations(context) {
    if (_customIconForBusStations == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
              configuration, 'assets/icons/bus_stop/bus_stop@2x.png')
          .then((icon) {
        setState(() {
          _customIconForBusStations = icon;
        });
      });
    }
  }

  createMarkerLiveBus(context) {
    if (_custoIconForLiveBus == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
              configuration, 'assets/icons/live_bus/bus_position@2x.png')
          .then((icon) {
        setState(() {
          _custoIconForLiveBus = icon;
        });
      });
    }
  }

  Future<String> _loadBusStopsBySelectedStation() async {
    if (widget.selectStation != 'All')
      return await rootBundle
          .loadString('assets/bus_stops/stops_${widget.selectStation}.json');
    return await loadMyStations();
  }

  Future<String> _loadRoutesBySelectedStation() async {
    if (widget.selectStation != 'All')
      return await rootBundle.loadString(
          'assets/routes_strings/coords_${widget.selectStation}.json');
    return await rootBundle.loadString('assets/bus_stops/AllBusStops.json');
  }

  Future<LiveBus> _liveBusStatisonFromAPI() async {
    final response = await http
        .get("$_baseUrl/$_command${widget.selectStation.toLowerCase()}");
    return LiveBus.fromJson(json.decode(response.body));
  }

  @override
  void dispose() {
    super.dispose();
    _liveBusStationsStream.cancel();
  }

  @override
  void initState() {
    super.initState();
    _defaultFunctionsOnStart();
    _busMonitor();
  }

  Future _busMonitor() async {
    _liveBusStationsStream =
        Stream.periodic(Duration(seconds: 5)).listen((data) async {
      LiveBus jsonParsed = await _liveBusStatisonFromAPI();

      jsonParsed.result.busPositions.forEach((f) {
        var markerId = _createMarketId('${f.busId}_live_bus');

        setState(() {
          markers[markerId] = _createMarketOnMap(
              markerId, _custoIconForLiveBus, f.latitude, f.longitude);
        });
      });
    });
  }

  Marker _createMarketOnMap(
      MarkerId id, BitmapDescriptor icon, double lat, double lng) {
    if (lat == null || lng == null) return null;

    return Marker(markerId: id, icon: icon, position: LatLng(lat, lng));
  }

  MarkerId _createMarketId(String id) {
    return MarkerId(id);
  }

  void _defaultFunctionsOnStart() {
    _futureBusStops = _loadBusStopsBySelectedStation();
    _futureRoutes = _loadRoutesBySelectedStation();
    _futureLiveBus = _liveBusStatisonFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    createMarkerForBusStations(context);
    createMarkerLiveBus(context);
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
            future:
                Future.wait([_futureBusStops, _futureRoutes, _futureLiveBus]),
            builder: (
              context,
              AsyncSnapshot<List> snapshot,
            ) {
              if (!snapshot.hasData) {
                return CustomLoading();
              }
              _createMarkesForBusStop(snapshot);
              _createInitialMarkesForLiveBus(snapshot);

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
                onMapCreated: _mapCreated,
                polylines: _createPolylineBetweenStations(snapshot),
              );
            },
          ),
        ),
      ]),
    );
  }

  Set<Polyline> _createPolylineBetweenStations(AsyncSnapshot<List> snapshot) {
    List<dynamic> parseJson = jsonDecode(snapshot.data[1]);

    Set<Polyline> allPolylinesByPosition = {};

    parseJson.forEach((element) {
      String coordsString = element["coords"];
      String color = widget.selectStation != 'All' ? element["colour"] : null;

      List<Map<String, String>> coords = [];

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

      List<LatLng> latlng = [];
      if (widget.selectStation != 'All') {
        coords.forEach((i) {
          latlng.add(LatLng(double.tryParse(i["latitude"] ?? 0.0),
              double.tryParse(i["longitude"] ?? 0.0)));

          hexToColor(String code) {
            String hash = "#";
            hash += code;
            return new Color(
                int.parse(hash.substring(1, 7), radix: 16) + 0xFF000000);
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
        });
      }
    });

    return allPolylinesByPosition;
  }

  void _createMarkesForBusStop(AsyncSnapshot<List> snapshot) {
    List<dynamic> parsedJson = jsonDecode(snapshot.data[0]);

    parsedJson.forEach((element) {
      var markerId = _createMarketId('${element['StopNumber']}_future_1');
      markers[markerId] = _createMarketOnMap(markerId,
          _customIconForBusStations, element['Latitude'], element['Longitude']);
    });
  }

  void _createInitialMarkesForLiveBus(AsyncSnapshot<List> snapshot) {
    LiveBus parsedJson = snapshot.data[2];

    parsedJson.result.busPositions.forEach((f) {
      var markerId = _createMarketId('${f.busId}_future_2');
      markers[markerId] = _createMarketOnMap(
          markerId, _customIconForBusStations, f.latitude, f.longitude);
    });
  }

  void _mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}
