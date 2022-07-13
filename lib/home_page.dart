// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:app/utill/habbit_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // overal habit summary
  List habitList = [
    // [ habitName, habitStarted, habitSpend, timeSpend (sec) ,timeGoal (min) ]
    ['Exercise', false, 0, 1],
    ['Read', false, 0, 20],
    ['Meditate', false, 0, 20],
    ['Code', false, 0, 40],
  ];

  void habitStarted(int index) {
    //Note what the start time this
    var startTime = DateTime.now();

    //include the time already elapsed
    int elapsedTime = habitList[index][2];

    // Habbit started or stop
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if (habitList[index][1]) {
      // keep the time going!
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (habitList[index][1] == false) {
            timer.cancel();
          }
          var currentTime = DateTime.now();
          habitList[index][2] = elapsedTime + currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settingsOpened(int index) {
    showDialog(
        context: context,
        builder: (context0) {
          return AlertDialog(
            title: Text('Settigns for ' + habitList[index][0]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Consytency is key'),
        centerTitle: false,
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: ListView.builder(
          itemCount: habitList.length,
          itemBuilder: (context, index) {
            return HabbitTile(
              habitName: habitList[index][0],
              onTap: () {
                habitStarted(index);
              },
              settingsTapped: () {
                settingsOpened(index);
              },
              habitStarted: habitList[index][1],
              timeSpant: habitList[index][2],
              timeGoal: habitList[index][3],
            );
          }),
    );
  }
}
