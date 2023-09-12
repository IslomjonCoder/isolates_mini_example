import 'dart:isolate';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Image.network(
                'https://media.giphy.com/media/l41lIvPtFdU3cLQjK/giphy.gif',
                height: 300,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    int total = calculate();
                    print(total);
                  },
                  child: const Text('Task 1')),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    final receivePort = ReceivePort();

                    await Isolate.spawn(calculateWithIsolate, receivePort.sendPort);
                    receivePort.listen((total) {
                      print(total);
                    });
                  },
                  child: const Text('Task 2')),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: const Text('Task 3')),
            ],
          ),
        ),
      ),
    );
  }
}

calculate() {
  int total = 0;
  for (int i = 0; i < 500000000; i++) {
    total += i;
  }

  return total;
}

calculateWithIsolate(SendPort sender) {
  int total = 0;
  for (int i = 0; i < 500000000; i++) {
    total += i;
  }
  sender.send(total);
}
