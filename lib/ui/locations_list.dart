import 'package:flutter/material.dart';
import 'package:gtbuddy/models/savedStations.dart';
import 'package:gtbuddy/blocs/location_list/location_bloc.dart';
import 'package:gtbuddy/resources/saved_stations.dart';
import 'package:gtbuddy/ui/tiles/dashboard_header_tile.dart';
import 'package:gtbuddy/utils/colour_pallete.dart';
import 'package:gtbuddy/utils/text_style.dart';

class LocationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LocationListState();
  }
}

class LocationListState extends State<LocationList> {


  void initState() {
    super.initState();
    bloc.fetchAllLocations(this.context);
  }

  final bloc = LocationBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select From"),
          centerTitle: true,
          leading: IconButton(icon:Icon(Icons.arrow_back_ios),
            onPressed:() => Navigator.pop(context, false),
          ),
          backgroundColor: Pallete.appBarColor,
        ),
        body: StreamBuilder(
          stream: bloc.allLocations,
          builder: (context, AsyncSnapshot<List<SavedStations>> snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}

@override
Widget buildList(AsyncSnapshot<List<SavedStations>> snapshot) {
  return Column(
    children: <Widget>[
      DashboardTile("MAIN SERVICE AREAS", 60.0),
      Container(
        height: 420,
        color: Pallete.BackgroundColour,
        child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Center(
                    child: Column(
                  // Stretch the cards in horizontal axis
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        SavedService()
                            .addtoList(snapshot.data[index].shortName);
                        Navigator.of(context).pop();

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            // Read the name field value and set it in the Text widget
                            snapshot.data[index].shortName,
                            // set some style to text
                            style: AppStyles.Results(),
                          ),
                          Divider()
                        ],
                      ),
                    ),
                  ],
                )),
                padding: const EdgeInsets.all(15.0),
              );
            }),
      ),
    ],
  );
}
