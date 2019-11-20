import 'package:flutter/material.dart';
import 'package:gtbuddy/src/ui/serviceAreas.dart';


class HomeScreen extends StatefulWidget {
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
                MaterialPageRoute(builder: (context) => ServiceArea()),
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
            child: Text("Hatfield"),

          ),
          Container(
            width: 400,
            height: 55,
            decoration: BoxDecoration(

              border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.grey), top: BorderSide(width: 0.5, color: Colors.white10)),
              color: Color.fromRGBO(239, 239, 244, 1),
            ),
//            margin: const EdgeInsets.only(left: 100.0, right: 20.0),
            padding: const EdgeInsets.only(left: 8.0, top: 30.0),

            child: Text("CLOSEST STATION",style: TextStyle(color: Colors.black54),),

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
            child: Text("ALL STATIONS",style: TextStyle(color: Colors.black54),),
          ),
          Container(
            width: 400,
            height: 65,
            decoration: BoxDecoration(

              border:
              Border(top: BorderSide(width: 0.5, color: Colors.grey),),
              color: Colors.white,
            ),

//            margin: const EdgeInsets.only(left: 100.0, right: 20.0),
            padding: const EdgeInsets.only(left: 8.0, top: 30.0),
            child: Text("All Stations"),

          ),
          Container(
            width: 400,
            height: 150,
            decoration: BoxDecoration(

              border:
              Border(top: BorderSide(width: 0.5, color: Colors.grey),),
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
