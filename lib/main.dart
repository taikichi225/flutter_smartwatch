import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sensors/sensors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const platform = MethodChannel("com.samples/shape");

  Future<Shape> detectWatchShape() async {
    try {
      final int result = await platform.invokeMethod("detectWatchShape");
      return result == 0 ? Shape.round : Shape.square;
    } catch (e) {
      print(e);
      // デフォルトを四角に設定
      return Shape.square;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: detectWatchShape(),
        builder: (BuildContext context, AsyncSnapshot<Shape> snapshot) {
          if(!snapshot.hasData)  return Center(child: CircularProgressIndicator(),);

          Shape shape = snapshot.data;
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;

          return StreamBuilder(
            stream: accelerometerEvents,
            builder: (context, AsyncSnapshot<AccelerometerEvent> eventSnapshot) {
              if(!eventSnapshot.hasData) return Center(child: CircularProgressIndicator(),);
              
              AccelerometerEvent event = eventSnapshot.data;

              switch(shape) {
                case Shape.round:
                  return Container(
                    height: height,
                    width: width,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("ROUND"),
                          Text("x: ${event.x}"),
                          Text("y: ${event.y}"),
                          Text("z: ${event.z}")
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                  );
                case Shape.square:
                  return Container(
                    height: height,
                    width: width,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("AQUARE"),
                          Text("x: ${event.x}"),
                          Text("y: ${event.y}"),
                          Text("z: ${event.z}")
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.blue,
                    ),
                  );
                default:
                  return Container(
                    color: Colors.red,
                  ); 
              }
            },
          );
        },
      )
    );
  }
}

enum Shape { round, square }