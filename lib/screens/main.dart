import 'package:dinamikortalamahesaplama/screens/not_hesapla.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        accentColor: Colors.deepOrangeAccent
      ),
      routes: {
        "/" : (context) => Home(),
        "/notHesapla" : (context) => NotHesapla()
      },
      initialRoute: "/",
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dinamik Ortalama Hesaplama")),
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Notlari Hesapla"),
            onPressed: () => Navigator.pushNamed(context, "/notHesapla"),
          ),
        ),
      ),
    );
  }
}

