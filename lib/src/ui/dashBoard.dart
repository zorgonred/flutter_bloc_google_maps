import 'package:flutter/material.dart';
import 'package:gtbuddy/services/services.dart';
import 'package:gtbuddy/src/models/busStations.dart';
import 'package:gtbuddy/src/resources/busStations_provider.dart';
import 'package:gtbuddy/src/ui/allStationsMap.dart';
import 'package:gtbuddy/src/ui/busStations.dart';
import 'package:gtbuddy/src/ui/components/serviceArea.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String selectedFromList;

  HomeScreen({Key key, @required this.selectedFromList}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Routes"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 62, 64, 1),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAppp()),
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: 400,
            height: 55,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
              color: Color.fromRGBO(239, 239, 244, 1),
            ),

//            margin: const EdgeInsets.only(left: 100.0, right: 20.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 30.0),
              child: Text(
                "SAVED STATIONS",
                style: TextStyle(color: Colors.black54),
              ),
            ),
//            color: Color.fromRGBO(239, 239, 244, 1),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapSample(
                          selectedStation: "Hatfield",
                        )),
              );
            },
            child: Container(
              height: 100,
              child: FutureBuilder<List<String>>(
                  future: SavedService().selectSavedStation(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
//                    print(snapshot.data[index]);
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        print(snapshot.data[index]);
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 30.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapSample(
                                      selectedStation: snapshot.data[index],
                                    )),
                              );
                            },

                            child: Text(
                              snapshot.data[index],
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data.length,
                    );
                  }),
            ),
//            child: Container(
//              width: 400,
//              height: 65,
//              decoration: BoxDecoration(
//
//                border:
//                Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
//                color: Colors.white,
//              ),
////            margin: const EdgeInsets.only(left: 100.0, right: 20.0),
//              padding: const EdgeInsets.only(left: 8.0, top: 30.0),
//              child: Text("Hatfield"),
//
//            ),
          ),
          Container(
            width: 400,
            height: 55,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Colors.grey),
                  top: BorderSide(width: 0.5, color: Colors.white10)),
              color: Color.fromRGBO(239, 239, 244, 1),
            ),
//            margin: const EdgeInsets.only(left: 100.0, right: 20.0),
            padding: const EdgeInsets.only(left: 8.0, top: 30.0),

            child: Text(
              "CLOSEST STATION",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Container(
            width: 400,
            height: 65,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
              color: Colors.white,
            ),
//            margin: const EdgeInsets.only(left: 100.0, right: 20.0),
            padding: const EdgeInsets.only(left: 8.0, top: 30.0),
            child: Text("Pretoria"),
          ),
          Container(
            width: 400,
            height: 55,
//            decoration: BoxDecoration(
//
//              border:
//              Border(top: BorderSide(width: 0.5, color: Colors.grey)),
//              color: Color.fromRGBO(239, 239, 244, 1),
//            ),
//            margin: const EdgeInsets.only(left: 100.0, right: 20.0),
            padding: const EdgeInsets.only(left: 8.0, top: 30.0),
            child: Text(
              "ALL STATIONS",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Container(
            width: 400,
            height: 65,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5, color: Colors.grey),
              ),
              color: Colors.white,
            ),

//            margin: const EdgeInsets.only(left: 100.0, right: 20.0),
//            padding: const EdgeInsets.only(left: 8.0, top: 30.0),
            child: FlatButton(
              textColor: Colors.black54,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapSample()),
                );
              },
              child: Align(
                  alignment: Alignment.centerLeft,
                  child:
              Text("All Stations",)),
            ),
          ),
          Container(
            width: 400,
            height: 110,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5, color: Colors.grey),
              ),
              color: Color.fromRGBO(239, 239, 244, 1),
            ),

//            margin: const EdgeInsets.only(left: 100.0, right: 20.0),
            padding: const EdgeInsets.only(left: 8.0, top: 30.0),
          ),
        ],
      ),
    );
  }
}
