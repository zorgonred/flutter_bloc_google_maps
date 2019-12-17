import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtbuddy/blocs/dashboard/dashboard_bloc.dart';
import 'package:gtbuddy/blocs/dashboard/dashboard_event.dart';
import 'package:gtbuddy/blocs/location_list/locationlist_bloc.dart';
import 'package:gtbuddy/blocs/location_list/locationlist_event.dart';
import 'package:gtbuddy/blocs/location_list/locationlist_state.dart';
import 'package:gtbuddy/models/locations.dart';
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
      body: BlocProvider(
        create: (ctx) => LocationlistBloc(),
        child: LocationLists(),
      ),
    );
  }
}

class LocationLists extends StatefulWidget {
  @override
  _LocationListsState createState() => _LocationListsState();
}

class _LocationListsState extends State<LocationLists> {
  LocationlistBloc _locationListBloc;

  @override
  void initState() {
    super.initState();
    _locationListBloc = BlocProvider.of<LocationlistBloc>(context);
    _locationListBloc.add(GetLocations());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<LocationlistBloc, LocationlistState>(
        builder: (context, state) {
          if (state is InitialLocationlistState) {
            print('Uninitialized');
            return CircularProgressIndicator();
          } else if (state is LocationListLoading) {
            print('loading...');
            return CircularProgressIndicator();
          } else if (state is LocationListLoaded) {
            print('loaded');
            return ListBuilder(state.stations);
          } else {
            print('Problem');
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _locationListBloc.drain();
  }
}

class ListBuilder extends StatelessWidget {
  List<Locations> _savedStations;

  ListBuilder(this._savedStations);

  @override
  Widget build(BuildContext context) {
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
                itemCount: _savedStations.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      {
                        BlocProvider.of<DashboardSavedBloc>(context).add(
                            AddSaved(
                                selected: _savedStations[index].shortName));
                      }

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
                              _savedStations[index].shortName,
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
}


