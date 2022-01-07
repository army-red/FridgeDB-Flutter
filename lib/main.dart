import 'package:flutter/material.dart';
import 'history.dart';
import 'dart:async';
import 'current.dart';
import 'temperature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  List tabs = [
    {
      'key': '冰箱',
    },
    {
      'key': '歷史記錄',
    },
    {
      'key': '溫度',
    },
    {
      'key': '設置',
    }
  ];

  var pages;

  @override
  Widget build(BuildContext context) {

    pages = [
      Current(),
      HistoryRecord(),
      Temp(),
      Home(Colors.black26, '3')
    ];
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          body: pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.teal,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon:
                      const Icon(Icons.padding),
                  title: Text(tabs[0]['key'])),
              BottomNavigationBarItem(
                  icon:
                      const Icon(Icons.history),
                  title: Text(tabs[1]['key'])),
              BottomNavigationBarItem(
                  icon:
                      const Icon(Icons.thermostat_outlined),
                  title: Text(tabs[2]['key'])),
              BottomNavigationBarItem(
                  icon:
                      const Icon(Icons.settings),
                  title: Text(tabs[3]['key'])),
            ],
            type: BottomNavigationBarType.fixed,
            iconSize: 24,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          )),
    );
  }

  Widget Home(Color bgcolor, String title) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      // ),
      body: Container(
        color: bgcolor,
      ),
    );
  }
}
