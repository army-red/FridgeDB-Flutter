import 'package:flutter/material.dart';
import 'mysql.dart';

class HistoryRecord extends StatefulWidget {
  const HistoryRecord({Key? key}) : super(key: key);

  @override
  State<HistoryRecord> createState() => _HistoryRecordState();
}



class _HistoryRecordState extends State<HistoryRecord> {
  Map icon2name = {
    "cow":const Icon(IconData(0xe64d, fontFamily: 'Foods'), size: 20,),
    "sheep":const Icon(IconData(0xe64a, fontFamily: 'Foods'), size: 20,),
    "person":const Icon(Icons.accessibility),
    "dog":const Icon(IconData(0xe637, fontFamily: 'Foods'), size: 20,),
    "bottle":const Icon(IconData(0xe627, fontFamily: 'Foods'), size: 20,),


  };
  @override
  Widget build(BuildContext context) {
    sql();
    return Scaffold(
      appBar: AppBar(
        title: const Text("History Food"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(

          itemCount: data.length,
          itemBuilder: (context, index) {
            var subtt = "Prob: " + data[index][1].toString().substring(0,4) + " Pos: " + data[index][2].toString() + " \nTime: " + data[index][4].toString();
            return ListTile(
              leading: icon2name[data[index][0]] ?? const Icon(Icons.help),
              title: Text(data[index][0]),
              subtitle: Text(subtt),
            );
          },
        ),
      ),
    );

  }
}