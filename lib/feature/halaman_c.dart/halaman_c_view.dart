import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HalamanC extends StatefulWidget {
  final List<double> accelerometerValues;
  final List<double> gyroscopeValues;
  final List<double> magnetometerValues;

  const HalamanC({
    Key? key,
    required this.accelerometerValues,
    required this.gyroscopeValues,
    required this.magnetometerValues,
  }) : super(key: key);

  @override
  _HalamanCState createState() => _HalamanCState();
}

class _HalamanCState extends State<HalamanC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman C'),
      ),
      body: Center(
        child: Column(
          children: [
            _buildChart('Accelerometer Data', widget.accelerometerValues),
            const SizedBox(height: 20),
            _buildChart('Gyroscope Data', widget.gyroscopeValues),
            const SizedBox(height: 20),
            _buildChart('Magnetometer Data', widget.magnetometerValues),
          ],
        ),
      ),
    );
  }
}

// Fungsi untuk membuat grafik
Widget _buildChart(String title, List<double> values) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: 1.5,
        child: LineChart(
          LineChartData(
            titlesData: const FlTitlesData(
                // leftTitles: SideTitles(showTitles: true),
                // bottomTitles: SideTitles(showTitles: true),
                ),
            gridData: const FlGridData(show: true),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            minX: 0,
            maxX: values.length.toDouble() - 1,
            minY: values.reduce((min, value) => min < value ? min : value),
            maxY: values.reduce((max, value) => max > value ? max : value),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  values.length,
                  (index) => FlSpot(index.toDouble(), values[index]),
                ),
                isCurved: true,
                color: Colors.blue,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
