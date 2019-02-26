import 'package:flutter/material.dart';

class MovieTrailerPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return _MovieTrailerPage();
  }
}

class _MovieTrailerPage extends State<MovieTrailerPage>{


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Movie name goes here"),
      ),
      body: Container(
        color: Colors.black,
      ),
    );
  }
}