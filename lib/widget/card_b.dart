import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class CardB extends StatelessWidget {
  // const CardB({super.key});
  DeviceInfoPlugin deviceinfo = DeviceInfoPlugin();

  AndroidDeviceInfo? androidInfo;

  CardB({super.key});
  Future<AndroidDeviceInfo> getInfo() async {
    return await deviceinfo.androidInfo;
  }

  Widget ShowCard(String name, String value) {
    return Card(
      child: ListTile(title: Text('$name : $value')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<AndroidDeviceInfo>(
        future: getInfo(),
        builder: (context, snapshot) {
          final data = snapshot.data!;
          return Column(children: [
            ShowCard('Model', data.model),
          ]);
        },
      )),
    );
  }
}
