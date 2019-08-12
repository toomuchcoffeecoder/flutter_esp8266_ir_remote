import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';

void main() async {
  // modify with your true address/port
  Socket sock = await Socket.connect('192.168.1.101', 80);
  runApp(MyApp(sock));
}

class MyApp extends StatelessWidget {
  Socket socket;

  MyApp(Socket s) {
    this.socket = s;
  }

  @override
  Widget build(BuildContext context) {
    final title = 'TcpSocket Demo';
    return MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
        channel: socket,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final Socket channel;

  MyHomePage({Key key, @required this.title, @required this.channel})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("AC On/Off",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0
                  )
                ),
                color: Colors.red,
                onPressed: _togglePower,
              ),
              RaisedButton(
                child: Text("Fan",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0
                    )
                ),
                color: Colors.red,
                onPressed: _fan,
              ),
              RaisedButton(
                child: Text("Mode",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0
                    )
                ),
                color: Colors.red,
                onPressed: _mode,
              ),
              RaisedButton(
                child: Text("Temp Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0
                    )
                ),
                color: Colors.red,
                onPressed: _tempUp,
              ),
              RaisedButton(
                child: Text("Temp Down",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0
                    )
                ),
                color: Colors.red,
                onPressed: _tempDown,
              ),
            ],
          ),
        )
      )
    );
  }

  void _togglePower() {
    widget.channel.write("POWER\n");
  }

  void _fan() {
    widget.channel.write("FAN\n");
  }

  void _mode() {
    widget.channel.write("MODE\n");
  }

  void _tempUp() {
    widget.channel.write("TEMPUP\n");
  }

  void _tempDown() {
    widget.channel.write("TEMPDOWN\n");
  }

  @override
  void dispose() {
    widget.channel.close();
    super.dispose();
  }
}