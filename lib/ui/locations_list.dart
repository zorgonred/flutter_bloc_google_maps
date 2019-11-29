import 'package:flutter/material.dart';
import 'package:gtbuddy/models/savedStations.dart';
import 'package:gtbuddy/blocs/location_list/location_bloc.dart';
import 'package:gtbuddy/resources/repository.dart';
import 'package:gtbuddy/services/services.dart';

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
          backgroundColor: Color.fromRGBO(59, 62, 64, 1),
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
  return  ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return
          Card(
            child:  Container(
              child:  Center(
                  child:  Column(
                    // Stretch the cards in horizontal axis
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      GestureDetector(
                        onTap: (){
                          SavedService().addtoList(snapshot.data[index].shortName);
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => HomeScreen(selectedFromList:busStation[index].short_name ,),
//                                 ));
                        },
                        child: Text(
                          // Read the name field value and set it in the Text widget
                          snapshot.data[index].shortName,
                          // set some style to text
                          style:  TextStyle(
                              fontSize: 20.0, color: Colors.black54),
                        ),
                      )
                    ],
                  )),
              padding: const EdgeInsets.all(15.0),
            ),
          );
      });
}
