import 'package:flutter/material.dart';


class ServiceArea extends StatefulWidget {
  @override
  _ServiceAreaState createState() => _ServiceAreaState();
}

class _ServiceAreaState extends State<ServiceArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select From"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 62, 64, 1),

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
                "MAIN SERVICE AREAS",
                style: TextStyle(color: Colors.black54),
              ),
            ),
//            color: Color.fromRGBO(239, 239, 244, 1),
          ),
          Column(
            children: <Widget>[
              Container(
                width: 400,
                height: 305,
//            margin: const EdgeInsets.only(left: 100.0, right: 20.0),
                padding: const EdgeInsets.only(left: 8.0, top: 30.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Centurion"),
                      Divider(),
                      Text("Midrand"),
                      Divider(),
                      Text("Sandton"),
                      Divider(),
                      Text("Rosebank"),
                      Divider(),
                      Text("Park"),
                      Divider(),
                      Text("Rhodesfield"),
                      Divider(),
                    ],
                  ),
                ),
                color: Colors.white,
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


        ],
      ),
    );
  }
}
