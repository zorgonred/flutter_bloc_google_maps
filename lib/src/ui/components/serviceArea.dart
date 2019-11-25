import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gtbuddy/services/services.dart';
import 'package:gtbuddy/src/models/busStations.dart';
import 'package:gtbuddy/src/ui/dashBoard.dart';

class busStationList extends StatelessWidget {
  final List<BusStations> busStation;
  busStationList({Key key, this.busStation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: busStation == null ? 0 : busStation.length,
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
                             SavedService().addtoList(busStation[index].short_name);
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => HomeScreen(selectedFromList:busStation[index].short_name ,),
//                                 ));
                           },
                           child: Text(
                            // Read the name field value and set it in the Text widget
                            busStation[index].short_name,
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
}