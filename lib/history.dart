import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class HistoryRecord extends StatefulWidget {
  const HistoryRecord({Key? key}) : super(key: key);

  @override
  State<HistoryRecord> createState() => _HistoryRecordState();
}

List data = [];

sql() async {

  var s = ConnectionSettings(
    user: "admin",
    password: "adminadmin",
    host: "database-2.clx9hdjaqqiv.us-east-1.rds.amazonaws.com",
    port: 3306,
    db: "image_recognition",

  );
  var tmp_data = [];
  // create a connection
  print("Opening connection ...");
  var conn = await MySqlConnection.connect(s);
  print("Opened connection!");

  var results = await conn.query('select * from things;');

  for (var row in results.toList()){
    try{
      var tmp = [row['name'],row['probability'],row['time_stamp'],row['inout']];
      tmp_data.add(tmp);
      // print(tmp);
    } catch (e){
      print('error $e');
    }
  }
  data = tmp_data;
  print(data);
  conn.close();
}

class _HistoryRecordState extends State<HistoryRecord> {
  Map icon2name = {
    "cow":const Icon(IconData(0xe64d, fontFamily: 'Foods'), size: 20,),
    "sheep":const Icon(IconData(0xe64a, fontFamily: 'Foods'), size: 20,),
    "person":const Icon(Icons.accessibility),
    "dog":const Icon(IconData(0xe637, fontFamily: 'Foods'), size: 20,),
    "bottle":const Icon(IconData(0xe627, fontFamily: 'Foods'), size: 20,),

    "motorcycle":const Icon(IconData(0xe6f6, fontFamily: 'Vehicle'), size: 20,),
    "car":const Icon(IconData(0xec6d, fontFamily: 'Vehicle'), size: 20,),
    "bus":const Icon(IconData(0xe8cd, fontFamily: 'Vehicle'), size: 20,),
    "truck":const Icon(IconData(0xeb36, fontFamily: 'Vehicle'), size: 20,),
  };


  List file = data;

  @override
  Widget build(BuildContext context) {
    sql();

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
      ),
      body: Container(
        // color: Colors.white,
        child: buildList(file),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sql();

          setState(() {
            // data = [];
            file = data;
          });
          print('file' + file.toString());
        },
        child: const Icon(
          Icons.refresh
        ),


      ),
    );

  }

  Widget buildList(file ) {
    return Container(
      color: Colors.teal,
      child: ListView.builder(
        itemCount: file.length,
        itemBuilder: (BuildContext context, int index) {
          var subtt = "Prob: " + file[index][1].toString().substring(0,4) + " \nTime: " + file[index][2].toString();
          return ListTile(

            leading: icon2name[file[index][0]] ?? const Icon(Icons.help),
            title: Text(file[index][0] + "    " + (file[index][3]==1 ? 'In' : 'Out')),
            subtitle: Text(subtt),
          );
        },
      ),
    );
  }
}