import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class HalamanB extends StatelessWidget {
  // const HalamanB({super.key});
  DeviceInfoPlugin deviceinfo = DeviceInfoPlugin();

  AndroidDeviceInfo? androidInfo;
  Future<AndroidDeviceInfo> getInfo() async {
    return await deviceinfo.androidInfo;
  }

  Widget ShowCard(String name, String value) {
    return Card(
      child: ListTile(
        title: Text('$name : $value'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman B'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder<AndroidDeviceInfo>(
            future: getInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No data available');
              }

              final data = snapshot.data!;
              return Column(
                children: [
                  ShowCard('brand', data.brand),
                  ShowCard('model', data.model),
                  ShowCard('manufacturer', data.manufacturer),
                  ShowCard('SDK', data.version.sdkInt.toString()),
                  ShowCard('release', data.version.release),
                  ShowCard('version code', data.version.codename),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
