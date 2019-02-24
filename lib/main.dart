import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() async {
  var data = await readData();
  if (data != null) {
    String message = await readData();
    print(message);
  }

  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'IO',
      home: new Home(),
    );
  }
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var enterDataField = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Google IO'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: new Container(
          child: new Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(top: 50.0),
          ),
          new TextField(
              controller: enterDataField,
              decoration: new InputDecoration(
                labelText: 'Write Something',
              )),
          new Padding(
            padding: new EdgeInsets.only(top: 30.0),
          ),
          new FlatButton(
            onPressed: () {
              writeData(enterDataField.text);
            },
            child: new Column(
              children: <Widget>[
                new Text('Save Data'),
                new Padding(padding: new EdgeInsets.all(16.0)),
                new FutureBuilder(
                  future: readData(),
                  builder: (BuildContext context, AsyncSnapshot<String> data) {
                    if (data.hasData != null) {
                      return new Text(
                        data.data.toString(),
                        style: new TextStyle(color: Colors.blueAccent),
                      );
                    } else {
                      return new Text('NO data Saved!!');
                    }
                  },
                )
              ],
            ),
            color: Colors.orange,
          )
        ],
      )),
    );
  }
}

//get  a ocal path
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
//create a fle on a path

Future<File> get _localFile async {
  final path = await _localPath;
  return new File('$path/data.txt');
}

//Write and read the data frorm the file;
Future<File> writeData(String message) async {
  final file = await _localFile;

  return file.writeAsString('$message');
}

Future<String> readData() async {
  try {
    final file = await _localFile;
    String data = await file.readAsString();
    return data;
  } catch (e) {
    return 'NOthing Saved Yet!!';
  }
}
