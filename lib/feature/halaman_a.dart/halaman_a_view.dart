import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:synapsis_test/feature/halaman_b.dart/halaman_b_view.dart';

import '../halaman_c.dart/halaman_c_view.dart';

class HalamanA extends StatefulWidget {
  const HalamanA({Key? key}) : super(key: key);

  @override
  State<HalamanA> createState() => _HalamanAState();
}

class _HalamanAState extends State<HalamanA> {
  late String formattedDate;
  List<double> _accelerometerValues = [0, 0, 0];
  List<double> _gyroscopeValues = [0, 0, 0];
  List<double> _magnetometerValues = [0, 0, 0];
  String _latitude = 'Unknown';
  String _longitude = 'Unknown';
  int _batteryLevel = 0;
  final Battery _battery = Battery();

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    formattedDate = formatter.format(now);

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
      });
    });

    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = [event.x, event.y, event.z];
      });
    });

    magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometerValues = [event.x, event.y, event.z];
      });
    });
    _getLocation();
    _getBatteryLevel();
    _requestLocationPermission();
  }

  Future<void> _getLocation() async {
    if (await Permission.location.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        setState(() {
          _latitude = position.latitude.toString();
          _longitude = position.longitude.toString();
        });
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Izin lokasi tidak diberikan");
    }
  }

  Future<void> _requestLocationPermission() async {
    final permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      _getLocation();
    } else {
      print('Izin lokasi tidak diberikan');
    }
  }

  Future<void> _getBatteryLevel() async {
    final level = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Halaman A'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Text('Tanggal dan Waktu saat ini : $formattedDate'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    child: Text(
                      'Gyroscope: \nX: ${_gyroscopeValues[0].toStringAsFixed(2)}\n'
                      'Y: ${_gyroscopeValues[1].toStringAsFixed(2)}\n'
                      'Z: ${_gyroscopeValues[2].toStringAsFixed(2)}',
                    ),
                  ),
                  Card(
                    child: Text(
                      'Magnetometer: \nX: ${_magnetometerValues[0].toStringAsFixed(2)}\n'
                      'Y: ${_magnetometerValues[1].toStringAsFixed(2)}\n'
                      'Z: ${_magnetometerValues[2].toStringAsFixed(2)}',
                    ),
                  ),
                  Card(
                    child: Text(
                      'Akselerometer: \nX: ${_accelerometerValues[0].toStringAsFixed(2)}\n'
                      'Y: ${_accelerometerValues[1].toStringAsFixed(2)}\n'
                      'Z: ${_accelerometerValues[2].toStringAsFixed(2)}',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                child: Text(
                  'Latitude: $_latitude',
                ),
              ),
              Card(
                child: Text(
                  'Longitude: $_longitude',
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: Text('Battery Level: $_batteryLevel %',
                    style: const TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HalamanB()));
                      },
                      child: const Text('Next B')),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HalamanC(
                            accelerometerValues: _accelerometerValues,
                            gyroscopeValues: _gyroscopeValues,
                            magnetometerValues: _magnetometerValues,
                          ),
                        ),
                      );
                    },
                    child: const Text('Next C'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
