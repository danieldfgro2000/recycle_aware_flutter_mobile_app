
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:recycle_aware_flutter_app/a_info_a_main_page.dart';
import 'package:recycle_aware_flutter_app/c_home_a_main_page.dart';
import 'package:recycle_aware_flutter_app/c_home_d_useful_b_draw_t2s_webview_3dprint.dart';
import 'package:recycle_aware_flutter_app/c_home_d_useful_b_draw_t2s_webview_customcnc.dart';

String avatarIm;
String printed3D;
String plasticG;
String custom;
class T2sPage extends StatefulWidget {
  @override
  _T2sPageState createState() => _T2sPageState();
}

class _T2sPageState extends State<T2sPage> {

  int currentIndex;

  var defaultURL = 'https://www.relyon-plasma.com/wp-content/uploads/2019/05/Motorradverkleidung.jpg';
  String avatarImage = 'https://www.relyon-plasma.com/wp-content/uploads/2019/05/Motorradverkleidung.jpg';
  String printedFairing = 'https://www.relyon-plasma.com/wp-content/uploads/2019/05/Motorradverkleidung.jpg';
  String plasticGear = 'https://www.mootio-components.com/imgprod/fotosprod/en/plastic-gear-011816-foto1.jpg';
  String customCNC = 'https://www.nordic-parts.dk/wp-content/uploads/2019/05/referencer_-1.png';


  @override

  Widget build(BuildContext context) {

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
              title: Text('t2s ', textScaleFactor: 0.5,),
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

          child:

          ListView(

            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SizedBox(height: 15),

                      OutlineButton(

                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              // ignore: missing_return
                              builder: (context){
                                avatarIm = avatarImage;

                                  if (avatarImage == printedFairing) {
                                    print("3D printing page loading");
                                            return T2sWebView3dpPage();
                                      }
                                  if (avatarImage == customCNC) {
                                    print("Custom CNC page loading");
                                    return T2sWebViewcncPage();
                                  }

                            },),);
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        highlightElevation: 1,
                        borderSide: BorderSide(color: Colors.grey),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              CircleAvatar(

//                                backgroundImage: NetworkImage(avatarImage),
                                radius: 150,
                                child: ClipOval(
                                  child: Image.network(
                                    avatarImage,
                                  ),
                                ),
                                backgroundColor: Colors.transparent,),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Image search',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal,),),),



                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15),
                      Text(
                        'Keywords',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal,),
                        textAlign: TextAlign.left,
                      ),

                      SizedBox(height: 15),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: <Widget>[
                            OutlineButton(
                              onPressed: () {
                                setState(() {
                                  avatarImage = printedFairing;
                                });

                                print('3d printed fairing URL: $avatarImage');
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              highlightElevation: 1,
                              borderSide: BorderSide(color: Colors.grey),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                        '3D printed',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.teal,),),),



                                  ],
                                ),
                              ),
                            ),
                            OutlineButton(
                              onPressed: () {
                                setState(() {
                                  avatarImage = plasticGear;
                                });

                                print('plastic gear URL: $avatarImage');
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              highlightElevation: 1,
                              borderSide: BorderSide(color: Colors.grey),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                        'plastic gear',
                                        style: TextStyle(fontSize: 15,
                                          color: Colors.teal,),),),

                                  ],
                                ),
                              ),
                            ),
                            OutlineButton(
                              onPressed: () {
                                setState(() {
                                  avatarImage = customCNC;
                                });

                                print('custom CNC URL: $avatarImage');
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              highlightElevation: 1,
                              borderSide: BorderSide(color: Colors.grey),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                        'CNC Custom',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.teal,),),),



                                  ],
                                ),
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 5),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            OutlineButton(
                              onPressed: () {
                                avatarImage = defaultURL;
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              highlightElevation: 1,
                              borderSide: BorderSide(color: Colors.grey),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

//                                    CircleAvatar(
//                                      backgroundImage: NetworkImage(PrintedFairing),
//                                      radius: 25,
//                                      backgroundColor: Colors.transparent,),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                        '3D printed',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.teal,),),),



                                  ],
                                ),
                              ),
                            ),
                            OutlineButton(
                              onPressed: () {
                                avatarImage = defaultURL;
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              highlightElevation: 1,
                              borderSide: BorderSide(color: Colors.grey),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

//                                    CircleAvatar(
//                                      backgroundImage: NetworkImage(PrintedFairing),
//                                      radius: 25,
//                                      backgroundColor: Colors.transparent,),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                        '3D printed',
                                        style: TextStyle(fontSize: 15,
                                          color: Colors.teal,),),),

                                  ],
                                ),
                              ),
                            ),
                            OutlineButton(
                              onPressed: () {
                                avatarImage = defaultURL;
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              highlightElevation: 1,
                              borderSide: BorderSide(color: Colors.grey),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

//                                    CircleAvatar(
//                                      backgroundImage: NetworkImage(PrintedFairing),
//                                      radius: 25,
//                                      backgroundColor: Colors.transparent,),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                        '3D printed',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.teal,),),),



                                  ],
                                ),
                              ),
                            ),
                          ]
                      ),
                    ],),
                ),

              ),


//              MyCustomForm(),

            ],
          ),

        )
    );
  }


}
