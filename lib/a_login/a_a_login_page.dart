import 'package:flutter/material.dart';
import '../a_b_services/a_sign_in.dart';
import '../c_home/c_a_main_page.dart';
import '../b_info/b_a_main_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0), // here the desired height
            child: AppBar(
                title: Text('Welcome', textScaleFactor: 1.2,),
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
                  IconButton(
                    icon: Icon(
                      Icons.stars,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // do something
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
                  ),

                ]),
            ),



      body: Container(
        height: double.infinity,
        width: double.maxFinite,

        child: ListView(

          children: <Widget>[
            Center(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      SizedBox(height: 1),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child:
                        Image.asset("assets/images/ecou_logo_crop.png",
                          width: double.infinity,
                          height: 170,
                          fit:BoxFit.fill,
                        ),
                      ),


                      SizedBox(height: 1),

                      Text(
                        'Explore (Demo)',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            ),
                      ),

                      SizedBox(height: 10),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child:
                        Image.asset("assets/images/walleve.png",
                          width: double.infinity,
                          height: 170,
                          fit:BoxFit.fill,
                        ),
                      ),


                      SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.only(left:150),
                        child: Container(
                           alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(5.0),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                          ]
                        ),
                      ),
                      ),

                            SizedBox(height: 10),

                        _signInButton(),
                  ],
                ),
              ),
            ),
        ],
        ),
    ));
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
          signInWithGoogle().whenComplete(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen();
                },
              ),
            );
          });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.black54),
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
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
