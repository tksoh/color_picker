import 'package:flutter/material.dart';

import 'color_picker.dart';
import 'color_picker_dialog.dart';

final themeColorList = [
  Colors.indigo,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.grey,
  Colors.brown,
  Colors.amber,
  Colors.orange,
  Colors.lime,
  Colors.red,
  Colors.purple,
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color screenPickerColor = Colors.blue;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => ColorPickerDialog(
                    colors: themeColorList,
                    initColor: screenPickerColor,
                    onSelected: (color) {
                      debugPrint('color selected: $color');
                      if (color != null) screenPickerColor = color;
                    },
                  ),
                );
              },
              child: const Text('Color Picker Dialog'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => ColorPickerPage(
                        selectedColor: screenPickerColor,
                        onSelected: (color) {
                          screenPickerColor = color;
                          debugPrint('color selected: $color');
                        },
                      ),
                    ),
                  );
                },
                child: const Text('Pick Color Page')),
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
