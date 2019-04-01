import 'package:flutter/material.dart';
import 'player_page.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailPage extends StatefulWidget {
  final movieObj;
  final index;

  MovieDetailPage({this.movieObj, this.index});

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailPage(movieObj: this.movieObj, index: this.index);
  }
}

class _MovieDetailPage extends State<MovieDetailPage> {
  final movieObj;
  final index;

  _MovieDetailPage({this.movieObj, this.index});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[


          Container(
            child: Hero(
              tag: 'MoviePanel ${index}',
              child: new Container(
                //padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
                //margin: EdgeInsets.fromLTRB(0, 15, 0, 0),

                height: 400,

                //width: 200,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  image: new DecorationImage(
                    image: NetworkImage(movieObj.img),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),


          Container(
            color: Colors.deepPurple,
            height: 50,
            padding: EdgeInsets.fromLTRB(50, 5, 0, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                
                Container(
                  width: 200,
                  child: Text(
                    
                    "" + movieObj.title,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontFamily: 'FrontPage',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment(0.8, 0),
                  width: 100 ,
                  child: InkWell(
                    onTap: () {
                      _launch(this.movieObj.link);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => MoviePlayer(movieObj: this.movieObj)));
                    },
                    child: new Icon(Icons.play_circle_filled,color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(50),
            child: Text(
              "Some summary about the movie. \n Some summary about the movie. \n Some summary about the movie. \n Some summary about the movie. \n Some summary about the movie. \n Some summary about the movie. \n Some summary about the movie. \n Some summary about the movie. \n ",
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontFamily: 'FrontPage',
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void  _launch (String urlString) async{
    if(await canLaunch(urlString)){
      await launch(urlString);
    }else{
      throw 'Could not launch';
    }
  }

}

