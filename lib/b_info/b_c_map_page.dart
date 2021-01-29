import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Completer<GoogleMapController> _controller = Completer();
  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
    });
  }
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(46.7687061,23.6074122),
    zoom: 12,
  );

//  Colina
  static final CameraPosition _kDEEE1 = CameraPosition(
      bearing: 270,
      target: LatLng(46.7524, 23.54359),
      tilt: 90,
      zoom: 17.5);

//  Plopilor
  static final CameraPosition _kDECDC = CameraPosition(
      bearing: 90,
      target: LatLng(46.7647682,23.5686718),
      tilt: 90,
      zoom: 18);

//  Oasului
  static final CameraPosition _kPSA = CameraPosition(
      bearing: 270,
      target: LatLng(46.8088598,23.603255),
      tilt: 90,
      zoom: 17.5);



  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: PreferredSize(
           preferredSize: Size.fromHeight(50.0), // here the desired height
           child: AppBar(
               title: Text('Recycle Map', textScaleFactor: 1,),
               actions: <Widget>[

              IconButton(
                icon: Icon(choices[0].icon),
                onPressed: () {
                  _goToDEEE1();
                  _select(choices[0]);
                },
              ),
              // action button
              IconButton(
                icon: Icon(choices[1].icon),
                onPressed: () {
                  _goToPSA();
                  _select(choices[1]);
                },
              ),
                 IconButton(
                   icon: Icon(choices[2].icon),
                   onPressed: () {
                     _goToDECDC();
                     _select(choices[2]);
                   },
                 ),
              // overflow menu
              PopupMenuButton<Choice>(
                  onSelected: _select,
                  itemBuilder: (BuildContext context) {
                    return choices.skip(3).map((Choice choice) {
                      return PopupMenuItem<Choice>(
                        value: choice,
                        child: Text(choice.title),
                      );
                    }).toList();
                  },
              ),
              ClipRRect(
                   borderRadius: BorderRadius.circular(10.0),
                   child:
                   Image.asset("assets/images/ecou_logo_crop.png",

                     fit:BoxFit.fill,
                   ),
              ),

           ]),
         ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

    );
  }

  Future<void> _goToDEEE1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kDEEE1));
  }
  Future<void> _goToPSA() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kPSA));
  }
  Future<void> _goToDECDC() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kDECDC));
  }
}


class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'DEEE', icon: Icons.radio),
  const Choice(title: 'PSA', icon: Icons.local_drink),
  const Choice(title: 'Building', icon: Icons.local_convenience_store),
  const Choice(title: 'DEEE', icon: Icons.directions_bus),
  const Choice(title: 'PSA', icon: Icons.directions_railway),
  const Choice(title: 'DCD', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return Card(
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}

