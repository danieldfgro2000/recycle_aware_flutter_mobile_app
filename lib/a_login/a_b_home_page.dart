
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/a_login/a_a_login_page.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/a_b_services/a_sign_in.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/c_home/c_b_creative_page.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/b_info/b_a_main_page.dart';
import 'file:///C:/Users/dmuncaciu/AndroidStudioProjects/recycle_aware_flutter_app/lib/c_home/c_d_order_page.dart';


class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: PreferredSize(
           preferredSize: Size.fromHeight(50.0), // here the desired height
           child: AppBar(
             title: Text('Home', textScaleFactor: 1.5,),

               leading:IconButton(
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
          height: double.infinity,
          width: double.maxFinite,

          child: ListView(

            children: <Widget>[
              Center(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[

                        SizedBox(height: 15),
//                        Creative
                        OutlineButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context){
                                              return CreativePage();},),);
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
                                    'Creative ',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.teal,),),),
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/surrealist.gif"),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
//                        Connect
                        OutlineButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context){
                                  return UsefulPage();},),);
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
                                    'Connect',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.teal,),),),
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/gears.png"),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,),

                              ],
                            ),
                          ),
                        ),
                       SizedBox(height: 20),
//                      Sign OUT
                       OutlineButton(
                           onPressed: () {
                             signOutGoogle();
                             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)
                             {return LoginPage();}), ModalRoute.withName('/'));
                           },
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                         highlightElevation: 2,
                         borderSide: BorderSide(color: Colors.grey),
                         child: Padding(
                           padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                           child: Row(
                             mainAxisSize: MainAxisSize.min,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Image(image: AssetImage("assets/images/google_logo.png"),
                                   height: 35.0),
                               Padding(
                                     padding: const EdgeInsets.only(left: 10),
                                 child: Text(
                                   'Sign out ' + name + '  ',
                                   style: TextStyle(
                                     fontSize: 20,
                                     color: Colors.teal,),),),
                               CircleAvatar(
                                 backgroundImage: NetworkImage(
                                   imageUrl,
                                 ),
                                 radius: 30,
                                 backgroundColor: Colors.transparent,),

                             ],
                           ),
                         ),
                       ),
                       SizedBox(height: 50),
                     ],),
                  ),
               ),
              ],
          ),
        )
    );
  }

}