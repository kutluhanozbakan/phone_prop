
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:all_sensors/all_sensors.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:phone_properties/flash_light.dart';
import 'package:phone_properties/proximity.dart';

import 'camera.dart';
import 'device_info.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  int _counter = 0;
  late List<double> _accelerometerValues;
  late List<double> _userAccelerometerValues;
  late List<double> _gyroscopeValues;
  late bool _proximityValues = false;

  void _incrementCounter() {
    accelerometerEvents!.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    });

    gyroscopeEvents!.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    });

    proximityEvents!.listen((ProximityEvent event) {
      setState(() {
        // event.getValue return true or false
        _proximityValues = event.getValue();
      });
    });
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           ElevatedButton(onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeviceInfo()));
           }, child: Text("Device Info")),
            ElevatedButton(onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => Proximity()));
           }, child: Text("Proximity (Working on it)")),
             ElevatedButton(onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => TorchController()));
           }, child: Text("Flash light")),
           ElevatedButton(onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraTest()));
           }, child: Text("Camera")),
           ],
           
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
