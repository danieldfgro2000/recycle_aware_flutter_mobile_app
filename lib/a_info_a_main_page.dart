
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycle_aware_flutter_app/a_info_b_why_page.dart';
import 'package:recycle_aware_flutter_app/a_info_d_what_page.dart';
import 'package:recycle_aware_flutter_app/a_info_c_map_a_main_page.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
         appBar: PreferredSize(
           preferredSize: Size.fromHeight(50.0), // here the desired height
           child: AppBar(
               title: Text('Recycle', textScaleFactor: 1.5,),
               actions: <Widget>[
                 ClipRRect(
                   borderRadius: BorderRadius.circular(10.0),
                   child:
                   Image.asset("assets/images/ecou_logo_crop.png",

                     fit:BoxFit.fill,
                   ),
                 ),


                 IconButton(
                   icon: Icon(
                     Icons.settings_applications,
                     color: Colors.white,
                   ),
                   onPressed: () {
                     // do something
                   },
                 )
               ]),
         ),
        body: Container(

          child: ListView(

            children: <Widget>[
              Center(
                  child: Container(

                    padding: EdgeInsets.all(5.0),
                    child: Column(

                      children: <Widget>[

                        SizedBox(height: 15),
                        OutlineButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context){
                                  return WhyPage();},),);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                              highlightElevation: 1,
                              borderSide: BorderSide(color: Colors.grey),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'Why? ',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.teal,),),),
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/whyrecycle_round.png"),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,),

                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        OutlineButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context){
                                  return MapPage();},),);
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          highlightElevation: 1,
                          borderSide: BorderSide(color: Colors.grey),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'Where? ',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.teal,),),),
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/googlemapround.png"),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,),

                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        OutlineButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context){
                                  return WherePage();},),);
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          highlightElevation: 1,
                          borderSide: BorderSide(color: Colors.grey),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'What? ',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.teal,),),),
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/recyclecollage_round.png"),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,),

                              ],
                            ),
                          ),
                        ),

                     ],),
                  ),
               ),
              ],
          ),
        )
    );
  }

}