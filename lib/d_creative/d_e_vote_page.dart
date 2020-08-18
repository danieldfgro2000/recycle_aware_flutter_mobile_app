import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../a_b_services/a_sign_in.dart';
import '../b_info/b_a_main_page.dart';
import '../c_home/c_a_main_page.dart';


class VotePage extends StatefulWidget {
  VotePage({this.app});
  final FirebaseApp app;

  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {

  int _ideacounter;

  DatabaseReference _ideacounterRef;
  DatabaseReference _votecountRef;
  DatabaseReference _messagesRef;

  StreamSubscription<Event> _ideacounterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  StreamSubscription<Event> _votecountSubscription;

  bool _anchorToBottom = false;

  String _kUserKey = name;
  String _kVoteKey = 'vote_key';

  DatabaseError _error;

  @override
  void initState() {
    super.initState();

    _ideacounterRef = FirebaseDatabase.instance.reference().child('idea_counter');
    _votecountRef = FirebaseDatabase.instance.reference().child('vote_counter');

    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);

    _messagesRef = database.reference().child('ideas');
                   database.reference().child('counter');
                   database.reference().child('vote_counter')
                       .once().then((DataSnapshot snapshot) {
            print('Connected to second database and read ${snapshot.value}');
                  });

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    _votecountRef.keepSynced(true);
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
          print('Child read messageSubscription from DB: ${event.snapshot.value}');
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
//    _votecountSubscription.cancel();
  }

  Future<void> _voteCounter() async {
    // Increment counter in transaction.
    final TransactionResult transactionResult =
    await _votecountRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      print("$mutableData test!!");
      return mutableData;

    });

      if (transactionResult.committed) {
      _messagesRef.push().set(<String, String>{
        _kUserKey: '$_kVoteKey ${transactionResult.dataSnapshot.value
        }'
      });
    }
      else { print('Transaction not committed.');
        if (transactionResult.error != null) {
            print(transactionResult.error.message);}
        }
  }

  Future<void> _increment() async {
    // Increment counter in transaction.
    final TransactionResult transactionResult =
    await _votecountRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      votecount = mutableData as String;
      return mutableData;
    });
    if (transactionResult.committed) {
      print('Vote increment succeded');
    }
      else { print('Transaction not committed.');
        if (transactionResult.error != null) {
      print(transactionResult.error.message);}
      }
  }
  String votecount;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
              title: Text('Vote ', textScaleFactor: 1.2,),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),

              actions: <Widget>[
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child:
                  Image.asset("assets/images/ecou_logo_crop.png",

                    fit:BoxFit.fill,
                  ),
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


              ]),
        ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 25),
          Flexible(
            child: Center(
              heightFactor: 0.5,
              child: _error == null
                  ? Text(
                      'Submited ideas: $_ideacounter idea${_ideacounter == 1 ? '' : 's'}.\n\n')
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
                  b.value.compareTo(a.value)
                  : null,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return Card(
                  color: Colors.teal,
                  elevation: 5,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        "assets/images/ecou_logo_crop.png",
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    trailing:
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed:
//                            _voteCounter,
                          () =>
                          _votecountRef.child(snapshot.key).set(_increment()),
                    ),

                    title: Text(
                      "User: ${snapshot.value['user_name']}\n"
                          "Description: ${snapshot
                          .value['idea_description']}\n"
                          "Vote count: ${snapshot.value['vote_counter']}",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

    );
  }

}