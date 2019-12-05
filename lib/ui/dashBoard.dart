import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtbuddy/resources/closest_station.dart';
import 'package:gtbuddy/resources/saved_stations.dart';
import 'package:gtbuddy/ui/tiles/dashboard_header_tile.dart';
import 'package:gtbuddy/ui/tiles/dashboard_result_tile.dart';
import 'package:gtbuddy/utils/colour_pallete.dart';
import 'package:gtbuddy/utils/text_style.dart';
import 'locations_list.dart';
import 'maptwo.dart';
import 'package:geocoder/geocoder.dart';


class HomeScreen extends StatefulWidget {
  final String selectedFromList;

  HomeScreen({Key key, @required this.selectedFromList}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<Map<String, dynamic>> _savedLocation(String shortName) async {
    String busStationsJson =
    await rootBundle.loadString('assets/locations/BusStations.json');

    List<dynamic> busStations = json.decode(busStationsJson);


    return busStations.singleWhere((element) {
      return element["short_name"] == shortName;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Routes"),
        centerTitle: true,
        backgroundColor: Pallete.appBarColor,
        actions: <Widget>[
          FlatButton(
            textColor: Pallete.White,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationList()),
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        color: Pallete.BackgroundColour,
        child: Column(
          children: <Widget>[
            DashboardTile("SAVED STATIONS", 60.0),
            Container(
              height: 180,
              child: FutureBuilder<List<String>>(
                  future: SavedService().selectSavedStation(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        print(snapshot.data[index]);
                        return Dismissible(
                          key: Key(snapshot.data[index]),
                          onDismissed: (direction) {
                            snapshot.data.removeAt(index);
                            SavedService().deleteFromDashboard(index);
                            Scaffold.of(context).showSnackBar(
                                new SnackBar(content: Text("Station Removed")));
                          },
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Pallete.Red,
                            child: Icon(
                              Icons.delete,
                              color: Pallete.White,
                            ),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 8.0, top: 30.0),
                            child: FutureBuilder(
                              future: _savedLocation(snapshot.data[index]),
                              builder: (ctx, asyncSnapShot) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MapTWo(
                                          selectStation: snapshot.data[index],
                                          selectCoords: snapshot.data[index],
                                          appBar: snapshot.data[index],
                                          initialLat:
                                          asyncSnapShot.data['latitude'],
                                          initialLong:
                                          asyncSnapShot.data['longitude'],
                                        ),
                                      ),
                                    );
                                    print(snapshot.data[index]);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data[index],
                                      ),
                                      Divider()
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data.length,
                    );
                  }),
            ),
            DashboardTile("CLOSEST STATIONS", 60.0),
            FutureBuilder(
              future: ClosestStation().closestLocation(),
              builder: (ctx, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                return snapshot.hasData
                    ? Container(
                        width: 400,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Pallete.White,
                        ),
                        padding: const EdgeInsets.only(left: 8.0, top: 30.0),
                        child: GestureDetector(
                            onTap: () {
                              print(snapshot.data);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapTWo(
                                          selectStation:
                                              snapshot.data['short_name'],
                                          selectCoords:
                                              snapshot.data['short_name'],
                                          appBar: snapshot.data['short_name'],
                                          initialLat: snapshot.data['latitude'],
                                          initialLong:
                                              snapshot.data['longitude'],
                                        )),
                              );
                            },
                            child: Text(snapshot.data['short_name'],style: AppStyles.Results(),)),
                      )
                    : CircularProgressIndicator();
              },
            ),
            DashboardTile("ALL STATIONS", 60.0),
            DashboardResultTile(
                "All stations",
                MapTWo(
                  selectStation: 'All',
                  appBar: "All Stations",
                  selectCoords: null,
                  initialLat: 0,
                  initialLong: 0,
                )),
            DashboardTile("", 30.0),
          ],
        ),
      ),
    );
  }




}
