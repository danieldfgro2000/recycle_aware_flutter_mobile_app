
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/b_info/b_a_main_page.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/c_home/c_home_page.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/e_connect/e_b_webview_plasma.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/e_connect/e_c_webview_cnc.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/e_connect/e_d_webview_laser.dart';

class UsefulPage extends StatefulWidget {
  @override
  _UsefulPageState createState() => _UsefulPageState();
}

class _UsefulPageState extends State<UsefulPage> {
    @override
  Widget build(BuildContext context) {
     return Scaffold(
         appBar: PreferredSize(
           preferredSize: Size.fromHeight(50.0), // here the desired height
           child: AppBar(
//               title: Text('Creative ', textScaleFactor: 0.5,),
               leading: IconButton(
                 icon: Icon(
                   Icons.arrow_back,
                   color: Colors.white,
                 ),
                 onPressed: () => Navigator.of(context).pop(),
               ),

               actions: <Widget>[
                 ClipRRect(
                   borderRadius: BorderRadius.circular(5.0),
                   child:
                   Image.asset("assets/images/ecou_logo_crop.png",

                     fit:BoxFit.scaleDown,
                   ),
                 ),

                 IconButton(
                   icon: Icon(
                     Icons.info_outline,
                     color: Colors.white,
                   ),
                   onPressed: () {
                     Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (context){
                           return InfoPage();},),);
                    },
                 ),
                 IconButton(
                   icon: Icon(
                     Icons.home,
                     color: Colors.white,
                   ),
                   onPressed: () {
                     Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (context){
                           return FirstScreen();},),);
                   },
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
//                        Write
                        OutlineButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context){
                                  return T2sWebView3dpPage();},),);
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
                                    'Plasma in 3D Print',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal,),),),
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/fairing.png"),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,),


                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
//                        Text2Scene
                        OutlineButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context){
                                  return T2sWebViewcncPage();},),);
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
                                    'Custom Plastic CNC',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal,),),),
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/cnc_round.png"),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
//                        Draw
                        OutlineButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context){
                                  return T2sWebViewlaserPage();},),);
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
                                    'SLS in 3D Print ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal,),),),
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/sls_round.png"),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,),

                              ],
                            ),
                          ),
                        ),



                       SizedBox(height: 20),


                     ],),
                  ),
               ),
              ],
          ),
        )
    );
  }

}