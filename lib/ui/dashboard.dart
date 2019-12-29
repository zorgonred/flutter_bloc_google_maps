import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtbuddy/blocs/dashboard/dashboard_bloc.dart';
import 'package:gtbuddy/blocs/dashboard/dashboard_event.dart';
import 'package:gtbuddy/blocs/dashboard/dashboard_state.dart';
import 'package:gtbuddy/blocs/map/map_bloc.dart';
import 'package:gtbuddy/blocs/map/map_event.dart';
import 'package:gtbuddy/services/dashboard_saved_stations.dart';
import 'package:gtbuddy/ui/tiles/dashboard_header_tile.dart';
import 'package:gtbuddy/ui/tiles/dashboard_result_tile.dart';
import 'package:gtbuddy/ui/tiles/loading.dart';
import 'package:gtbuddy/utils/colour_pallete.dart';
import 'package:gtbuddy/utils/text_style.dart';

import 'locations_list.dart';
import 'map.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
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
                MaterialPageRoute(builder: (context) => LocList()),
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocProvider(
        create: (ctx) => DashboardSavedBloc(),
        child: Saved(),
      ),
    );
  }
}

class Saved extends StatefulWidget {
  @override
  SavedState createState() => SavedState();
}

class SavedState extends State<Saved> {
  DashboardSavedBloc _dashboardSavedBloc;

  @override
  void initState() {
    super.initState();
    _dashboardSavedBloc = BlocProvider.of<DashboardSavedBloc>(context);
    _dashboardSavedBloc.add(LoadSaved());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<DashboardSavedBloc, DashboardSavedState>(
        builder: (context, state) {
          if (state is Initial) {
            print('Uninitialized');
            return CustomLoading();
          } else if (state is SavedLoading) {
            print('loading...');
            return CustomLoading();
          } else if (state is SavedLoaded) {
            print('loaded');
            return ListBuilder(state.savedStationss, state.closest);
          } else if (state is SavedNotLoaded) {
            print('Problem');
            return CustomLoading();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _dashboardSavedBloc.drain();
  }
}

class ListBuilder extends StatelessWidget {
  List<String> _savedStations;
  Map<String, dynamic> _closest;

  ListBuilder(this._savedStations, this._closest);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.BarHeadColor,
      child: Column(
        children: <Widget>[
          DashboardTile("SAVED STATIONS", 50.0),
          Container(
            height: 180,
            color: Pallete.BackgroundColour,
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: _savedStations.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(_savedStations[index]),
                    onDismissed: (direction) {
                      _savedStations.removeAt(index);
                      SavedService().deleteSavedStation(index);
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
                    child: FutureBuilder(
                      future: SavedService()
                          .selectGeoBusStation(_savedStations[index]),
                      builder: (ctx, asyncSnapShot) {
                        return GestureDetector(
                          onTap: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => MapLocations(
//                                        selectStation: _savedStations[index],
//                                        selectCoords: _savedStations[index],
//                                        appBar: _savedStations[index],
//                                        initialLat:
//                                            asyncSnapShot.data['latitude'],
//                                        initialLong:
//                                            asyncSnapShot.data['longitude'],
//                                      )),
//                            );

                            BlocProvider.of<MapBloc>(context).add(
                                GetMapLocations(
                                    selectStation: _savedStations[index],
                                    selectCoords: _savedStations[index],
                                    appBar: _savedStations[index],
                                    initialLat: asyncSnapShot.data['latitude'],
                                    initialLong:
                                        asyncSnapShot.data['longitude']));

                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 12),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _savedStations[index],
                                    style: AppStyles.Results(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
          DashboardTile("CLOSEST STATIONS", 50.0),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Pallete.White,
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
                onTap: () {
                  print(_closest['short_name']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapLocations(
                              selectStation: _closest['short_name'],
                              selectCoords: _closest['short_name'],
                              appBar: _closest['short_name'],
                              initialLat: _closest['latitude'],
                              initialLong: _closest['longitude'],
                            )),
                  );
                },
                child: Text(
                  _closest['short_name'],
                  style: AppStyles.Results(),
                )),
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
    );
  }
}
