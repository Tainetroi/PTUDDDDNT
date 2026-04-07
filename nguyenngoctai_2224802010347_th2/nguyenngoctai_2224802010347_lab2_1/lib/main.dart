import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: LayoutApp()));
  }
}

class LayoutApp extends StatelessWidget {
  const LayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ← Task 3: Thêm Padding
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "I'm in a Column and Centered. The below is a row.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Task 1 + Task 4 đã hoàn thành
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Task 1
            children: [
              Container(width: 100, height: 100, color: Colors.red),
              const SizedBox(width: 16),
              Container(width: 100, height: 100, color: Colors.green),
              const SizedBox(width: 16),
              Container(width: 100, height: 100, color: Colors.blue),
            ],
          ),

          const SizedBox(height: 20),

          // Task 2: Stack alignment = topLeft
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(width: 300, height: 200, color: Colors.yellow),
              const Padding(
                padding: EdgeInsets.all(8.0), // cho chữ không dính sát góc
                child: Text(
                  'Stacked on Yellow Box',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
