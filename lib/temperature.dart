import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class Temp extends StatefulWidget {
  const Temp({Key? key}) : super(key: key);

  @override
  State<Temp> createState() => _TempState();
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

  var results = await conn.query('select * from temp;');

  for (var row in results.toList()){
    try{
      // DateTime time = DateTime.parse(row['time_stamp']);
      var tmp = [row['temp_now'],row['time_stamp'],row['error']];
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

class _TempState extends State<Temp> {
  Map icon2name = {
    "cow":const Icon(IconData(0xe64d, fontFamily: 'Foods'), size: 20,),
    "sheep":const Icon(IconData(0xe64a, fontFamily: 'Foods'), size: 20,),
    "person":const Icon(Icons.accessibility),
    "dog":const Icon(IconData(0xe637, fontFamily: 'Foods'), size: 20,),
    "bottle":const Icon(IconData(0xe627, fontFamily: 'Foods'), size: 20,),
  };

  List file = data;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Temperature"),
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
      color: Colors.black87,
      child: ListView.builder(
        itemCount: file.length,
        itemBuilder: (BuildContext context, int index) {
          var subtt = "Time: " + file[index][1].toString();
          return ListTile(
            // tileColor: file[index][0] > 0 ? Colors.red : Colors.white,
            leading: file[index][0] > 0 ? const Icon(Icons.whatshot,size: 25,) : const Icon(Icons.icecream,size: 25),
            title: Text(
                file[index][0].toString() + '℃',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: file[index][0] > 0 ? Colors.red : Colors.blueAccent,
              ),
            ),
            subtitle: Text(subtt),
          );
        },
      ),
    );
  }
}