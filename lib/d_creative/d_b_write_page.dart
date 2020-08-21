import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../a_b_services/a_sign_in.dart';
import '../b_info/b_a_main_page.dart';
import '../c_home/c_a_main_page.dart';

class WritePage extends StatefulWidget {
  WritePage({this.app});

  final FirebaseApp app;

  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {

  int _ideacounter;
  int _votecounter;
  int _uservotecounter;

  DatabaseReference _ideacounterRef;
  DatabaseReference _votecounterRef;
  DatabaseReference _messagesRef;
  DatabaseReference _userVoteRef;
  DatabaseReference _userVoteCountRef;

  StreamSubscription<Event> _ideacounterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  StreamSubscription<Event> _votecounterSubscription;

  bool _anchorToBottom = false;
  bool _isButtonDisabled = false;

  String _kUserKey = 'user_name';
  String _kUserVote = "user_vote";
  String _kVoteKey = 'vote_counter';
  String _kIdea_no_Key = 'idea_number';
  String _kIdea_des_Key = 'idea_description';
  String _kIdea_ID_key = 'ideas_generated_keys';

  DatabaseError _error;

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);

    _ideacounterRef = database.reference().child('idea_counter');
    _votecounterRef = database.reference().child('vote_counter');
    _messagesRef = database.reference().child('ideas');
    _userVoteRef = database.reference().child('user_vote');
    _userVoteCountRef = database
        .reference()
        .child('user_vote')
        .child('$_kIdea_ID_key')
        .child('$name');

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    _ideacounterRef.keepSynced(true);

    _ideacounterSubscription = database
        .reference()
        .child('idea_counter')
        .onValue
        .listen((Event event) {
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

    _votecounterSubscription = database
        .reference()
        .child('vote_counter')
        .onValue
        .listen((Event event) {
      if (mounted) {
        setState(() {
          _error = null;
          _votecounter = event.snapshot.value ?? 0;
          // ignore: unnecessary_statements
        });
      } else
        null;
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });

    _messagesSubscription =
        _messagesRef.limitToLast(10).onChildAdded.listen((Event event) {
      print('Read available entries: ${event.snapshot.value}');
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
      _votecounter = 0;
      _messagesRef.push().set(<String, String>{
        _kUserKey: '$name',
        _kIdea_des_Key: '$ideaDescription',
        _kIdea_no_Key: '$_ideacounter',
        _kVoteKey: '$_votecounter'
      });
    }

    else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  Future<void> _voteIncrement() async {
    // Increment counter in transaction.
    final TransactionResult transactionResult =
    await _votecounterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = _uservotecounter ?? 0;
      return mutableData;
    });

    if (_uservotecounter > 1) {
      print(
          'deactivate_thumbUp <_isButtonDisabled= True> value for _uservotecounte= $_uservotecounter');
      setState(() {
        _isButtonDisabled = true;
      });
    }

    else if (transactionResult.committed) {
      print(
          "_voteIncrement transaction committed, _uservotecounter  =  $_uservotecounter");
      _messagesRef.child(_kIdea_ID_key).update(<String, String>{
        _kVoteKey: '$_uservotecounter'
      });
    }

    else {
      print('_voteIncrement: ! Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
//    _uservotecounter = 0;
  }

  Future<void> _userVoteIncrement() async {
    // allow only one vote / user / idea

    print(
        "_allowOneVote <Start> Value for _uservotecounter is: $_uservotecounter");

    final TransactionResult transactionResult =
    await _userVoteRef.child(_kIdea_ID_key).child(name).runTransaction((
        MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });
    if (transactionResult.committed) {
      _votecounterSubscription =
          FirebaseDatabase.instance
              .reference()
              .child('user_vote')
              .child(_kIdea_ID_key)
              .child(name)
              .onValue
              .listen((Event event) {
            if (mounted) {
              setState(() {
                _voteIncrement();
                _error = null;
                _uservotecounter = event.snapshot.value ?? 0;
                print(
                    "_allowOneVote <_votecounterSubscription> Value changed => _uservotecounter= ${event
                        .snapshot.value}");
              });
            }
          }, onError: (Object o) {
            final DatabaseError error = o;
            setState(() {
              _error = error;
            });
          });
    }
    else {
      print('_allowOneVote Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  Future<void> _ideaDecrement() async {
    // Increment counter in transaction.
    final TransactionResult transactionResult =
    await _ideacounterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) - 1;
      return mutableData;
    });

    if (transactionResult.committed) {
      print(
          "_ideaDecrement <Transaction Commited>  idea count = $_ideacounter");
    }

    else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> deactivate_thumbUp() async {
    if (_uservotecounter >= 1) {
      print(
          'deactivate_thumbUp <_isButtonDisabled= True> value for _uservotecounte= $_uservotecounter');
      setState(() async {
        _isButtonDisabled = true;
      });
    }

    else {
      print(
          'deactivate_thumbUp <_isButtonDisabled= False> value for _uservotecounte= $_uservotecounter');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                    'Submited ideas: $_ideacounter idea${_ideacounter == 1
                        ? ''
                        : 's'}.\n\n '
                        'Vote count: $_votecounter'

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
              flex: 10,
              child: FirebaseAnimatedList(
                key: ValueKey<bool>(_anchorToBottom),
                query: _messagesRef,
                reverse: _anchorToBottom,
                sort: _anchorToBottom
                    ? (DataSnapshot a, DataSnapshot b) =>
                    b.value('vote_counter').compareTo(a.value('vote_counter'))
                    : null,

                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return Card(
                    color: Colors.cyan,
                    elevation: 5,

                    child: ListTile(
                      leading:
                      IconButton(
                        color: Colors.amber,
                        disabledColor: Colors.black12,
                        onPressed:
                        _isButtonDisabled ? null : () async {
                          print("Thumb: _uservotecounter = ${snapshot
                              .value['vote_counter']}");
//                              _uservotecounter = snapshot.value['vote_counter'];
                          if ((_uservotecounter ?? 0) <= 1) {
                            setState(() {
                              _kIdea_ID_key = '${snapshot.key}';
                            });
                            _userVoteIncrement();
                            print(
                                "_Vote Button clicked: Ideas transaction ID  $_kIdea_ID_key");
                          }
                          // ignore: unnecessary_statements
                          else {
//                                null;
                            if (SemanticsFlag.isSelected != null) {
                              setState(() =>
                              {
                                _isButtonDisabled = true,
                                print('Button disabled'),});
                            }
                          }
                        }
                        ,
                        icon: Icon(
                          Icons.thumb_up,
                          color: Colors.amber,
                        ),

                      ),

                      trailing: IconButton(
                        onPressed: () =>
                        {
                          _messagesRef.child(snapshot.key).remove(),
                          _userVoteRef.child(snapshot.key).remove(),

                          _ideaDecrement(),
                          print("Delete btn pressed"),
                        },

                        icon: Icon(Icons.delete),
                      ),

                      title: Text(

                        "User: ${snapshot?.value['user_name']}\n"
                            "Description: ${snapshot
                            ?.value['idea_description']}\n"
                            "Vote count: ${snapshot?.value['vote_counter']}",
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

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formkey,
        child: Column(

            children: <Widget>[

              // Add TextFormFields and RaisedButton here.
              SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: '''Please write down your Idea here
as detailed as possible,
then hit the Submit Button.'''
                ), // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  print(value);
                  ideaDescription = value;
                  return null;
                },
              ),
              SizedBox(height: 5),

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