
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/b_info/b_a_main_page.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/a_login/a_b_home_page.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/d_creative/d_b_write_page.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/d_creative/d_c_t2s_demo.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/d_creative/d_e_vote_page.dart';

class CreativePage extends StatefulWidget {
  @override
  _CreativePageState createState() => _CreativePageState();
}

class _CreativePageState extends State<CreativePage> {
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
                                  return WritePage();},),);
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
                                    'Write',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal,),),),
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/pencil_round.png"),
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
                                  return T2sWebViewdemoPage();},),);
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
                                    'Txt2Scene',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal,),),),
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/t2s_round.png"),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
//                        Draw
//                        OutlineButton(
//                          onPressed: () {
//                            Navigator.of(context).push(
//                              MaterialPageRoute(
//                                builder: (context){
//                                  return DrawPage();},),);
//                          },
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(20)),
//                              highlightElevation: 1,
//                              borderSide: BorderSide(color: Colors.grey),
//                          child: Padding(
//                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
//                            child: Row(
//                              mainAxisSize: MainAxisSize.max,
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//
//                                Padding(
//                                  padding: const EdgeInsets.all(5.0),
//                                  child: Text(
//                                    'Draw ',
//                                    style: TextStyle(
//                                      fontSize: 20,
//                                      color: Colors.teal,),),),
//                                CircleAvatar(
//                                  backgroundImage: AssetImage("assets/images/eve_round.png"),
//                                  radius: 50,
//                                  backgroundColor: Colors.transparent,),
//
//                              ],
//                            ),
//                          ),
//                        ),
//                        SizedBox(height: 20),
//                        Vote
                        OutlineButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context){
                                  return VotePage();},),);
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
                                    'Vote ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal,),),),
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/vote_round.png"),
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