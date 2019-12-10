import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gtbuddy/blocs/location_bloc.dart';
import 'package:gtbuddy/blocs/station_bloc.dart';
import 'package:gtbuddy/ui/tiles/dashboard_header_tile.dart';
import 'package:gtbuddy/ui/tiles/dashboard_result_tile.dart';
import 'package:gtbuddy/ui/tiles/loading.dart';
import 'package:gtbuddy/utils/colour_pallete.dart';
import 'package:gtbuddy/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'locations_list.dart';
import 'map_locations.dart';

class HomeScreen extends StatefulWidget {
  final String selectedFromList;

  HomeScreen({Key key, @required this.selectedFromList}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final locationBloc = BlocProvider.getBloc<LocationBloc>();
  final stationBloc = BlocProvider.getBloc<StationBloc>();

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
        color: Pallete.BarHeadColor,
        child: Column(
          children: <Widget>[
            DashboardTile("SAVED STATIONS", 50.0),
            Container(
              height: 180,
              color: Colors.white,
              child: FutureBuilder<List<String>>(
                  future: stationBloc.selectSavedStation(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        print(snapshot.data[index]);
                        return Dismissible(
                          key: Key(snapshot.data[index]),
                          onDismissed: (direction) {
                            snapshot.data.removeAt(index);
                            stationBloc.deleteSavedStationByIndex(index);
                            Scaffold.of(context).showSnackBar(
                                new SnackBar(content: Text("Station Removed")));
                            setState(() {});
                          },
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Pallete.Red,
                            child: Icon(
                              Icons.delete,
                              color: Pallete.White,
                            ),
                          ),
                          child: FutureBuilder(
                            future: locationBloc
                                .savedLocation(snapshot.data[index]),
                            builder: (ctx, asyncSnapShot) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MapLocations(
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
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        snapshot.data[index],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                      itemCount: snapshot.data.length,
                    );
                  }),
            ),
            DashboardTile("CLOSEST STATIONS", 50.0),
            FutureBuilder(
              future: locationBloc.closestLocation(),
              builder: (ctx, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                return snapshot.hasData
                    ? Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Pallete.White,
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapLocations(
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
                            child: Text(
                              snapshot.data['short_name'],
                              style: AppStyles.Results(),
                            )),
                      )
                    : CustomLoading();
              },
            ),
            DashboardTile("ALL STATIONS", 50.0),
            DashboardResultTile(
                "All stations",
                MapLocations(
                  selectStation: 'All',
                  appBar: "All Stations",
                  selectCoords: null,
                  initialLat: 0,
                  initialLong: 0,
                ))
          ],
        ),
      ),
    );
  }
}
