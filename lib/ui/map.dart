import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gtbuddy/blocs/map/map_bloc.dart';
import 'package:gtbuddy/blocs/map/map_event.dart';
import 'package:gtbuddy/blocs/map/map_state.dart';
import 'package:gtbuddy/models/map_bus_live.dart';
import 'package:gtbuddy/services/map.dart';
import 'package:gtbuddy/ui/dashboard.dart';
import 'package:gtbuddy/ui/tiles/loading.dart';
import 'package:flutter/services.dart';
import 'dart:async';



class GoogleMapp extends StatefulWidget {
  String appBar;
  double initialLat;
  double initialLong;


  GoogleMapp(this.appBar, this.initialLat, this.initialLong);

  @override
  _GoogleMappState createState() => _GoogleMappState();
}

class _GoogleMappState extends State<GoogleMapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.appBar}'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => HomeScreen()))),
        backgroundColor: Color.fromRGBO(59, 62, 64, 1),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            textColor: Colors.white,
            child: Text("Nearest", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: BlocProvider(
        create: (ctx) => MapBloc(),
        child: Mapt(widget.appBar, widget.initialLat, widget.initialLong),
      ),
    );
  }
}

class Mapt extends StatefulWidget {
  String station;
  double initialLat;
  double initialLong;


  Mapt(this.station, this.initialLat, this.initialLong);

  @override
  _MaptState createState() => _MaptState();
}

class _MaptState extends State<Mapt> {
  MapBloc _mapBlocloc;

  @override
  void initState() {

    super.initState();


    _mapBlocloc = BlocProvider.of<MapBloc>(context);

    _mapBlocloc.add(GetMapLocations(
        selectStation: widget.station,
        selectCoords: widget.station,
      initialLat: widget.initialLat,
      initialLong: widget.initialLong,

    ));
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<MapBloc, MapLocState>(
        builder: (context, state) {
          if (state is InitialMapState) {
            print('Uninitialized');
            return CustomLoading();
          } else if (state is MapLoading) {
            print('loading...');
            return CustomLoading();
          }
          if (state is MapLoaded) {
            print('loaded');
            return MapBuilder(state.loadRoutesBySelectedStation, state.loadBusBySelectedStation,  state.initialLat, state.initialLong,state.liveBusStatisonFromAPI,);
          } else {
            print('Problem');
            return Text("problem");
          }
        },
      ),
    );
  }


}

class MapBuilder extends StatefulWidget {
  String loadRoutesBySelectedStation;
  String loadBusBySelectedStation;
  double initialLat;
  double initialLong;
  LiveBus liveBusStatisonFromAPI;


  MapBuilder(this.loadRoutesBySelectedStation, this.loadBusBySelectedStation, this.initialLat, this.initialLong, this.liveBusStatisonFromAPI);

  @override
  _MapBuilderState createState() => _MapBuilderState();
}

class _MapBuilderState extends State<MapBuilder> {
  GoogleMapController _controller;
  static const LatLng _center = const LatLng(33.738045, 73.084488);
  LatLng _lastMapPosition = _center;
  List<Marker> allMarkers = <Marker>[];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor _customIconForBusStations;
  BitmapDescriptor _customIconForLiveBus;
  StreamSubscription _liveBusStationsStream;

  @override
  void dispose() {
    super.dispose();
    _liveBusStationsStream.cancel();
  }

  @override
  void initState() {

    super.initState();
    _busMonitor();


  }

  @override
  Widget build(BuildContext context) {
    createMarkerForBusStations(context);
    createMarkerLiveBus(context);
    _createMarkesForBusStop();
    _createInitialMarkesForLiveBus();

    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
//          Text(widget.loadRoutesBySelectedStation),
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                    widget.initialLat,
                    widget.initialLong,
                  )
                      ,
                  zoom: 8.0),

              onMapCreated: _mapCreated,
              markers: Set<Marker>.of(markers.values),
              polylines: _createPolylineBetweenStations(),

            )
        )
      ],
    );
  }

  Marker _createMarketOnMap(MarkerId id, BitmapDescriptor icon, double lat, double lng) {
    if (lat == null || lng == null) return null;

    return Marker(markerId: id,  icon: icon, position: LatLng(lat, lng));
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
    if (_customIconForLiveBus == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/icons/live_bus/bus_position@2x.png').then((icon) {
        setState(() {
          _customIconForLiveBus = icon;
        });
      });
    }
  }

  void _createInitialMarkesForLiveBus() async {
    LiveBus jsonParsed = await widget.liveBusStatisonFromAPI;

    jsonParsed.result.busPositions.forEach((f) {
      var markerId = _createMarketId('${f.busId}_future_2');
      markers[markerId] = _createMarketOnMap(
          markerId, BitmapDescriptor.defaultMarker, f.latitude, f.longitude);
    });
  }

  Future _busMonitor() async {
    _liveBusStationsStream = Stream.periodic(Duration(seconds: 5)).listen((data) async {
      LiveBus jsonParsed = await widget.liveBusStatisonFromAPI;

      jsonParsed.result.busPositions.forEach((f) {
        var markerId = _createMarketId('${f.busId}_live_bus');

        setState(() {
          markers[markerId] = _createMarketOnMap(markerId,BitmapDescriptor.defaultMarker, f.latitude, f.longitude);
        });
      });
    });
  }



  void _createMarkesForBusStop() {
    List<dynamic> parsedJson = jsonDecode(widget.loadBusBySelectedStation);

    parsedJson.forEach((element) {
      var markerId = _createMarketId('${element['StopNumber']}_future_1');
      markers[markerId] = _createMarketOnMap(markerId,
          _customIconForBusStations, element['Latitude'], element['Longitude']);
    });

  }

  Set<Polyline> _createPolylineBetweenStations() {
    List<dynamic> parseJson = jsonDecode(widget.loadRoutesBySelectedStation);

    Set<Polyline> allPolylinesByPosition = {};

    parseJson.forEach((element) {
      String coordsString = element["coords"];
      String color = widget.loadRoutesBySelectedStation != 'All' ? element["colour"] : null;

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
      if (widget.loadRoutesBySelectedStation != 'All') {
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

  MarkerId _createMarketId(String id) {
    return MarkerId(id);
  }

  void _mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}
