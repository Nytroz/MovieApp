import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class MoviePlayer extends StatefulWidget{
  final movieObj;
  
  MoviePlayer({this.movieObj});

  @override
  State<StatefulWidget> createState() {
    return _MoviePlayer(movieObj: this.movieObj);
  }

}

class _MoviePlayer extends State<MoviePlayer> {
  final movieObj;

  _MoviePlayer({this.movieObj});

  @override
  Widget build(BuildContext context) {
   
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Webview"),
      ),
      url: '' +movieObj.link ,
      withJavascript: true,
      withZoom: true,
      scrollBar: true,
    );
  }
}