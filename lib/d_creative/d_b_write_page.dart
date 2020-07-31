import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../b_info/b_a_main_page.dart';
import '../a_b_services/a_sign_in.dart';
import '../c_home/c_a_main_page.dart';



class WritePage extends StatefulWidget {
  WritePage({this.app});
  final FirebaseApp app;

  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  int _ideacounter;

  DatabaseReference _ideacounterRef;
  DatabaseReference _votecounterRef;
  DatabaseReference _messagesRef;


  StreamSubscription<Event> _ideacounterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  StreamSubscription<Event> _votecounterSubscription;

  bool _anchorToBottom = false;


  String _kUserKey = name;
//  String _kUserValue = 'idea_subscription';
  String _kVoteKey = 'vote_key';
  String _kVoteValue = 'vote_value';

  DatabaseError _error;

  @override
  void initState() {
    super.initState();

    _ideacounterRef = FirebaseDatabase.instance.reference().child('idea_counter');
    _votecounterRef = FirebaseDatabase.instance.reference().child('vote_counter');

    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);

    _messagesRef = database.reference().child('ideas');
                   database.reference().child('counter');
                   database.reference().child('vote_counter')
                       .once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    _votecounterRef.keepSynced(true);
//    _votecounterSubscription = _votecounterRef.onValue.listen((Event event) {
//      setState(() {
//        _error = null;
//        _votecounterRef = event.snapshot.value ?? 0;
//      });
//    }, onError: (Object o) {
//      final DatabaseError error = o;
//      setState(() {
//        _error = error;
//      });
//    });

    _ideacounterRef.keepSynced(true);
    _ideacounterSubscription = _ideacounterRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        _ideacounter = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });
    _messagesSubscription =
        _messagesRef.limitToLast(10).onChildAdded.listen((Event event) {
          print('Child read to confirm added: ${event.snapshot.value}');
        }, onError: (Object o) {
          final DatabaseError error = o;
          print('Error: ${error.code} ${error.message}');
        });
  }


  @override
  void dispose() {
    super.dispose();
    _messagesSubscription.cancel();
    _ideacounterSubscription.cancel();
    _votecounterSubscription.cancel();
  }

  Future<void> _ideaSubmit() async {
    // Increment counter in transaction.
    final TransactionResult transactionResult =
    await _ideacounterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });

    if (transactionResult.committed) {
      _messagesRef.push().set(<String, String>{
        _kUserKey: ' $ideaDescription ${transactionResult.dataSnapshot.value}'
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  Future<void> _voteIncrement() async {
    // Increment counter in transaction.
    final TransactionResult transactionResult =
    await _ideacounterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });

    if (transactionResult.committed) {
      _messagesRef.push().set(<String, String>{
        _kVoteKey: ' $_kVoteValue  ${transactionResult.dataSnapshot.value}'
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      key: _formkey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
//              title: Text('Write ', textScaleFactor: 0.9,),
              leading:
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
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

        body:Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children:  <Widget>[
            SizedBox(height: 5),
//                        Write down yo Idea
            Flexible(

              child: Center(

                heightFactor: 1,
                child: _error == null
                    ? Text(
                    'Submited ideas: $_ideacounter idea${_ideacounter == 1 ? '' : 's'}.\n\n'

                )
                    : Text(
                  'Error retrieving button tap count:\n${_error.message}',
                ),
              ),
            ),

            ListTile(

              leading: Checkbox(
                onChanged: (bool value) {
                  setState(() {
                    _anchorToBottom = value;
                  });
                },
                value: _anchorToBottom,
              ),
              title: const Text('Sort by most voted ideas'),
            ),

            Flexible(

              child: FirebaseAnimatedList(
                key: ValueKey<bool>(_anchorToBottom),
                query: _messagesRef,
                reverse: _anchorToBottom,
                sort: _anchorToBottom
                    ? (DataSnapshot a, DataSnapshot b) => b.value.compareTo(a.value)
                    : null,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: ListTile(
                      leading:
                      IconButton(
                        onPressed: () =>
                            _votecounterRef.child(snapshot.key).set(0),
                        icon: Icon(Icons.thumb_up,

                          ),

                      ),

                      trailing: IconButton(
                        onPressed: () =>
                            _messagesRef.child(snapshot.key).remove(),
                        icon: Icon(Icons.delete),
                      ),
                      title: Text(
                        "${snapshot.value.toString()}",
                      ),
                    ),
                  );
                },
              ),
            ),

           MyCustomForm()

          ],
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: _ideaSubmit,
        tooltip: 'Submit',
          child: const Icon(Icons.add),
    ),
    );
  }

}

//    Write text field

String ideaDescription;
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}// Define a corresponding State class.

class MyCustomFormState extends State<MyCustomForm> {
//  ideaDescription = value;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formkey,
        child: Column(

            children: <Widget>[

              // Add TextFormFields and RaisedButton here.
              SizedBox(height: 50),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            hintText: '''Please write down your Idea here
as detailed as possible,
then hit the Submit Button.'''
                        ),// The validator receives the text that the user has entered.
                validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    print(value);
                    ideaDescription = value;
            return null;
            },
            ),
              SizedBox(height: 20),

              OutlineButton(
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formkey.currentState.validate()) {

                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    Scaffold
                        .of(context)
                        .showSnackBar(SnackBar(content: Text('Processing Data')));
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                highlightElevation: 1,
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.teal,),),),

                    ],
                  ),
                ),
              ),

            ]
        )
    );

  }
}