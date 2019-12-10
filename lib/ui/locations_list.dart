import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gtbuddy/blocs/location_bloc.dart';
import 'package:gtbuddy/blocs/station_bloc.dart';
import 'package:gtbuddy/models/saved_stations.dart';
import 'package:gtbuddy/ui/tiles/dashboard_header_tile.dart';
import 'package:gtbuddy/ui/tiles/loading.dart';
import 'package:gtbuddy/utils/colour_pallete.dart';
import 'package:gtbuddy/utils/text_style.dart';
import 'package:flutter/material.dart';

class LocationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LocationListState();
  }
}

class LocationListState extends State<LocationList> {

  final bloc = BlocProvider.getBloc<LocationBloc>();

  void initState() {
    super.initState();
    bloc.fetchAllLocations(this.context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select From"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context, false),
          ),
          backgroundColor: Pallete.appBarColor,
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: bloc.allLocations,
            builder: (context, AsyncSnapshot<List<SavedStations>> snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot, context);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return CustomLoading();
            },
          ),
        ));
  }
}

@override
Widget buildList(
    AsyncSnapshot<List<SavedStations>> snapshot, BuildContext context) {
  final stationBloc = BlocProvider.getBloc<StationBloc>();

  return Container(
    color: Pallete.BarHeadColor,
    child: Column(
      children: <Widget>[
        DashboardTile("MAIN SERVICE AREAS", 50.0),
        Container(
          height: MediaQuery.of(context).size.height,
          color: Pallete.BackgroundColour,
          child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    stationBloc.saveStationOnMySavedStation(
                        snapshot.data[index].shortName);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snapshot.data[index].shortName,
                            style: AppStyles.Results(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    ),
  );
}
