import 'dart:math';

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../a_login/a_a_login_page.dart';


void main() {
  runApp(MyApp());
}

class Model {
  int counter;

  Model(this.counter);
  //1- Synchronous

  void incrementMutable() {
    counter++;
  }

  Model incrementImmutable() {
    //immutable returns a new instance
    return Model(counter + 1);
  }

  //2- Async Future
  Future<void> futureIncrementMutable() async {
    //Pessimistic 😢: wait until future completes without error to increment
    await Future.delayed(Duration(seconds: 1));
    if (Random().nextBool()) {
      throw Exception('ERROR 😠');
    }
    counter++;
  }

  Future<Model> futureIncrementImmutable() async {
    await Future.delayed(Duration(seconds: 1));
    if (Random().nextBool()) {
      throw Exception('ERROR 😠');
    }
    return Model(counter + 1);
  }

  //3- Async Stream
  Stream<void> streamIncrementMutable() async* {
    //Optimistic 😄: start incrementing and if the future completes with error
    //go back the the initial state
    final oldCounter = counter;
    print(oldCounter);
    yield counter++;

    await Future.delayed(Duration(seconds: 1));
    if (Random().nextBool()) {
      yield counter = oldCounter;
      throw Exception('ERROR 😠');
    }
  }

  Stream<Model> streamIncrementImmutable() async* {
    yield Model(counter + 1);

    await Future.delayed(Duration(seconds: 1));
    if (Random().nextBool()) {
      yield this;
      throw Exception('ERROR 😠');
    }
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Injector(
      inject: [Inject(() => Model(0))],
      builder: (context) {
        return MaterialApp(
          home: MyHome(),
        );
      },
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('states_rebuilder'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SetStateCanDoAll(),
              Divider(),
              PessimisticAsync(),
              Divider(),
              PessimisticAsyncOnInitState1(),
              Divider(),
              PessimisticAsyncOnInitState2(),
              Divider(),
              OptimisticAsync(),
              Divider(),
              OptimisticAsyncOnInitState(),
            ],
          ),
        ));
  }
}

class SetStateCanDoAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //StateBuilder is one of four observer widgets
    return StateBuilder<Model>(
      //get the ReactiveModel of the injected Model instance,
      //and subscribe this StateBuilder to it.
      observe: () => RM.get<Model>(),
      builder: (context, modelRM) {
        //The builder exposes the BuildContext and the Model ReactiveModel
        return Column(
          children: [
            //get the state of the model
            Text('${modelRM.state.counter}'),
            // ignore: deprecated_member_use
            RaisedButton(
              child: Text('Increment (SetStateCanDoAll)'),
              onPressed: () async {
                //setState treats mutable and immutable objects equally
                modelRM.setState(
                  //mutable state mutation
                      (currentState) => currentState.incrementMutable(),
                );
                modelRM.setState(
                  //immutable state mutation
                      (currentState) => currentState.incrementImmutable(),
                );

                //await until the future completes
                await modelRM.setState(
                  //await for the future to complete and notify observer with
                  //the corresponding connectionState and data
                  //future will be canceled if all observer widgets are removed from
                  //the widget tree.
                      (currentState) => currentState.futureIncrementMutable(),
                );
                //
                await modelRM.setState(
                      (currentState) => currentState.futureIncrementImmutable(),
                );

                //await until the stream is done
                await modelRM.setState(
                  //subscribe to the stream and notify observers.
                  //stream subscription are canceled if all observer widget are removed
                  //from the widget tree.
                      (currentState) => currentState.streamIncrementMutable(),
                );
                //
                await modelRM.setState(
                      (currentState) => currentState.streamIncrementImmutable(),
                );
                //setState can do all; mutable, immutable, sync, async, futures or streams.
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
      },
    );
  }
}

class PessimisticAsync extends StatelessWidget {
  //pessimistic means we will execute an async method and wait it result.
  //While waiting, we will display a waiting screen.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //WhenRebuilder is the second of the four observer widgets
        WhenRebuilder<Model>(
          //subscribe to the global ReactiveModel
          observe: () => RM.get<Model>(),
          onSetState: (context, modelRM) {
            //side effects here
            modelRM.whenConnectionState(
              onIdle: () => print('Idle'),
              onWaiting: () => print('onWaiting'),
              onData: (data) => print('onData'),
              onError: (error) => print('onError'),
            );
          },
          onIdle: () => Text('The state is idle'),
          onWaiting: () => Text('Future is executing, we are waiting ....'),
          onError: (error) => Text('Future completes with error $error'),
          onData: (Model data) => Text('${data.counter}'),
        ),
        ElevatedButton(
          child: Text('Increment (PessimisticAsync - shouldAwait)'),
          onPressed: () {
            //All other widget subscribe to the global ReactiveModel will be notified to rebuild
            RM.get<Model>().setState(
                  (currentState) => currentState.futureIncrementImmutable(),
                  //will await the current future if its pending
                  //before calling futureIncrementImmutable
                  shouldAwait: true,
                );
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}

class PessimisticAsyncOnInitState1 extends StatelessWidget {
  //The async method will be call when this widget is inserted in the widget tree
  @override
  Widget build(BuildContext context) {
    return StateBuilder(
      //Create a local ReactiveModel model that decorate the false value
      observe: () => RM.create<bool>(false),
      builder: (context, switchRM) {
        //builder expose the BuildContext and the locally created ReactiveModel.
        return Column(
          children: [
            if (switchRM.state)
              WhenRebuilder<Model>(
                //get the global ReactiveModel and call setState
                //All other widget subscribed to this global ReactiveModel will be notified
                observe: () => RM.get<Model>()
                  ..setState(
                        (currentState) {
                      return currentState.futureIncrementImmutable();
                    },
                  ),
                onSetState: (context, modelRM) {
                  //side effects
                  if (modelRM.hasError) {
                    //show a SnackBar on error
                    final ScaffoldMessengerState scaffoldMessenger =
                        ScaffoldMessenger.of(context);
                    scaffoldMessenger.hideCurrentSnackBar();
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('${modelRM.error}'),
                      ),
                    );
                  }
                },
                onIdle: () => Text('The state is not mutated at all'),
                onWaiting: () =>
                    Text('Future is executing, we are waiting ....'),
                onError: (error) => Text('Future completes with error $error'),
                onData: (Model data) => Text('${data.counter}'),
              )
            else
              Container(),
            ElevatedButton(
              child: Text(
                  '${switchRM.state ? "Dispose" : "Insert"} (PessimisticAsyncOnInitState1)'),
              onPressed: () {
                //mutate the state of the local ReactiveModel directly
                //without using setState although we can.
                //setState gives us more features that we do not need here
                switchRM.state = !switchRM.state;
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
      },
    );
  }
}

class PessimisticAsyncOnInitState2 extends StatelessWidget {
  //The same as in PessimisticAsyncOnInitState but here the rebuild is locally.
  //only this widget will rebuild.
  @override
  Widget build(BuildContext context) {
    return StateBuilder(
        observe: () => RM.create(false),
        builder: (context, switchRM) {
          return Column(
            children: [
              if (switchRM.state)
                WhenRebuilder<Model>(
                  //Here use the future method to create new reactive model
                  observe: () => RM.get<Model>().future(
                        (currentState, stateAsync) {
                      //future method exposed the current state and teh Async representation of the state
                      return currentState.futureIncrementImmutable();
                    },
                  ),
                  ////This is NOT equivalent to this : (uncomment to try)
                  //// observe: () => RM.future(
                  ////   IN.get<Model>().futureIncrementImmutable(),
                  //// ),

                  onIdle: () => Text('The state is not mutated at all'),
                  onWaiting: () =>
                      Text('Future is executing, we are waiting ....'),
                  onError: (error) =>
                      Text('Future completes with error $error'),
                  onData: (Model data) => Text('${data.counter}'),
                )
              else
                Text('This widget will not affect other widgets'),
              ElevatedButton(
                child: Text(
                    '${switchRM.state ? "Dispose" : "Insert"} (PessimisticAsyncOnInitState2)'),
                onPressed: () {
                  switchRM.state = !switchRM.state;
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          );
        });
  }
}

class OptimisticAsync extends StatelessWidget {
  //Optimistic means, we will execute an async method and instantly display its expected result.
  //When the async method fails we will  undo the change and display an error message.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //WhenRebuilderOr is the third observer widget
        WhenRebuilderOr<Model>(
          observe: () => RM.get<Model>(),
          onWaiting: () => Text('Future is executing, we are waiting ....'),
          builder: (context, modelRM) => Text('${modelRM.state.counter}'),
        ),
        ElevatedButton(
          child: Text('Increment (OptimisticAsync - debounceDelay)'),
          onPressed: () {
            RM.get<Model>().setState(
              (currentState) => currentState.streamIncrementMutable(),
              //debounce setState for 1 second
              debounceDelay: 1000,
              onError: (context, error) {
                final ScaffoldMessengerState scaffoldMessenger =
                    ScaffoldMessenger.of(context);
                scaffoldMessenger.hideCurrentSnackBar();
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('$error'),
                  ),
                );
              },
            );
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}

class OptimisticAsyncOnInitState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateBuilder(
      observe: () => RM.create(false),
      builder: (context, switchRM) {
        return Column(
          children: [
            if (switchRM.state)
              WhenRebuilderOr<Model>(
                //Create a new ReactiveModel with the stream method.

                observe: () => RM.get<Model>().stream((state, subscription) {
                  //It exposes the current state and the current StreamSubscription.
                  return state.streamIncrementImmutable();
                }),

                ////This is NOT equivalent to this : (uncomment to try)
                //// observe: () => RM.stream(
                ////   IN.get<Model>().streamIncrementImmutable(),
                //// ),
                ///
                onSetState: (context, modelRM) {
                  if (modelRM.hasError) {
                    final ScaffoldMessengerState scaffoldMessenger =
                        ScaffoldMessenger.of(context);
                    scaffoldMessenger.hideCurrentSnackBar();
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('${modelRM.error}'),
                      ),
                    );
                  }
                },
                builder: (context, modelRM) {
                  return Text('${modelRM.state.counter}');
                },
              )
            else
              Text('This widget will not affect other widgets'),
            ElevatedButton(
              child: Text(
                  '${switchRM.state ? "Dispose" : "Insert"} (OptimisticAsyncOnInitState)'),
              onPressed: () {
                switchRM.state = !switchRM.state;
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
      },
    );
  }
}




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Injector(
      inject: [Inject(() => Model(0))],
      builder: (context) {
        return MaterialApp(
          title: 'ECO-U',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.green,
            accentColor: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.orange,
      ),
          home: LoginPage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  final String title = 'Be The ECO-U';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body:

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/ecou_logo.png"),
            TextButton(
                onPressed: () {
                  print('button pressed');
                },
                child: Image.asset("assets/images/you_idea_btn.png")),
          ],
        ));
  }
}
