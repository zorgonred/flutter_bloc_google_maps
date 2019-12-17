//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:gtbuddy/blocs/location_list/location_list_state.dart';
//import 'package:gtbuddy/blocs/map/map_bloc.dart';
//import 'package:gtbuddy/blocs/map/map_event.dart';
//import 'package:gtbuddy/blocs/map/map_state.dart';
//import 'package:gtbuddy/models/map_bus_live.dart';
//import 'package:gtbuddy/utils/colour_pallete.dart';
//
//class Map extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return MapState();
//  }
//}
//
//class MapState extends State<Map> {
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Select From"),
//        centerTitle: true,
//        leading: IconButton(
//          icon: Icon(Icons.arrow_back_ios),
//          onPressed: () => Navigator.pop(context, false),
//        ),
//        backgroundColor: Pallete.appBarColor,
//      ),
//      body: BlocProvider(
//        create: (ctx) => MapBloc(),
//        child: Maps(),
//      ),
//    );
//  }
//}
//
//class Maps extends StatefulWidget {
//  @override
//  _MapsState createState() => _MapsState();
//}
//
//class _MapsState extends State<Maps> {
//  MapBloc _mapBlocloc;
//  String selectStation;
//  String selectCoords;
//  String appBar;
//  var initialLat;
//  var initialLong;
//
//  @override
//  void initState() {
//    super.initState();
//    _mapBlocloc = BlocProvider.of<MapBloc>(context);
//    _mapBlocloc.add(GetMapLocations(
//        selectStation, selectCoords, appBar, initialLat, initialLong));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: BlocBuilder<MapBloc, MapLocState>(
//        builder: (context, state) {
//          if (state is InitialLocationListState) {
//            print('Uninitialized');
//            return CircularProgressIndicator();
//          } else if (state is MapLoading) {
//            print('loading...');
//            return CircularProgressIndicator();
//          } else if (state is MapLoaded) {
//            print('loaded');
//            return MapBuilder(
//                state.loadRoutesBySelectedStation,
//                state.liveBusStatisonFromAPI,
//                state.loadBusStopsBySelectedStation);
//          } else {
//            print('Problem');
//            return CircularProgressIndicator();
//          }
//        },
//      ),
//    );
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _mapBlocloc.drain();
//  }
//}
//
//
//
//class MapBuilder extends StatelessWidget {
//  String _loadRoutesBySelectedStation;
//  LiveBus _liveBusStatisonFromAPI;
//  String _loadBusStopsBySelectedStation;
//
//  MapBuilder(this._loadRoutesBySelectedStation, this._liveBusStatisonFromAPI,
//      this._loadBusStopsBySelectedStation);
//
//
//
//
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('${_loadRoutesBySelectedStation}'),
//        centerTitle: true,
//        leading: IconButton(
//          icon: Icon(Icons.arrow_back_ios),
//          onPressed: () => Navigator.pop(context, false),
//        ),
//        backgroundColor: Color.fromRGBO(59, 62, 64, 1),
//        actions: <Widget>[
//          FlatButton(
//            onPressed: () {},
//            textColor: Colors.white,
//            child: Text(
//              "Nearest",
//              style: TextStyle(color: Colors.white),
//            ),
//          ),
//        ],
//      ),
//      body: Stack(children: [
//        Container(
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
//          child: GoogleMap(
//                initialCameraPosition: CameraPosition(
//                    target: _loadRoutesBySelectedStation != 'All'
//                        ? LatLng(
//                            0.0,
//                            0.0,
//                          )
//                        : LatLng(
//                            -25.851942,
//                            28.189608,
//                          ),
//                    zoom: 8.0),
//                markers: Set<Marker>.of(markers.values),
//                onMapCreated: _mapCreated,
//                polylines: _createPolylineBetweenStations(snapshot),
//              );
//            },
//          ),
//        ),
//      ]),
//    );
//  }
//
//Set<Polyline> _createPolylineBetweenStations(AsyncSnapshot<List> snapshot) {
//  List<dynamic> parseJson = jsonDecode(snapshot.data[1]);
//
//  Set<Polyline> allPolylinesByPosition = {};
//
//  parseJson.forEach((element) {
//    String coordsString = element["coords"];
//    String color = widget.selectStation != 'All' ? element["colour"] : null;
//
//    List<Map<String, String>> coords = [];
//
//    String lat = '';
//    String long = '';
//    bool isLat = true;
//
//    for (int i = 0; i < coordsString.length; i++) {
//      if (coordsString[i] != ',' && coordsString[i] != '~') {
//        isLat ? lat += coordsString[i] : long += coordsString[i];
//      } else {
//        if (coordsString[i] == ',') {
//          isLat = false;
//        } else {
//          isLat = true;
//          coords.add({'latitude': lat, "longitude": long});
//          lat = '';
//          long = '';
//        }
//      }
//    }
//
//    List<LatLng> latlng = [];
//    if (widget.selectStation != 'All') {
//      coords.forEach((i) {
//        latlng.add(LatLng(double.tryParse(i["latitude"] ?? 0.0),
//            double.tryParse(i["longitude"] ?? 0.0)));
//
//        hexToColor(String code) {
//          String hash = "#";
//          hash += code;
//          return new Color(
//              int.parse(hash.substring(1, 7), radix: 16) + 0xFF000000);
//        }
//
//        allPolylinesByPosition.add(
//          Polyline(
//            polylineId: PolylineId((_lastMapPosition.toString())),
//            points: latlng,
//            visible: true,
//            width: 4,
//            color: hexToColor(color),
//          ),
//        );
//      });
//    }
//  });
//
//  return allPolylinesByPosition;
//}
//}
