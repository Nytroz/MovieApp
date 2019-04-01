import 'package:flutter/material.dart';
import 'package:loginfirebaseexample/movie_page.dart';
import 'dart:async';
//import 'load_event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieRow extends StatelessWidget {
  //final _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: _fetchFutureData(),
        //initialData: new <List<VideoObj>>,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            //if list of movies returned from server request
            if (snapshot.data != null) {
              //if the list is not still null
              return new Container(
                //padding: EdgeInsets.all(20),
                //color: Colors.white,
                child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      elevation: 5,
                      margin: EdgeInsets.all(15) ,
                      //color: Colors.greenAccent,
                      child: Column(
                        children: <Widget>[
                           Hero(
                            tag: 'MoviePanel ${snapshot.data[index].index}',
                           child: Container(
                            //padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
                            //margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child:  Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  highlightColor: Colors.white,
                                  onTap: (){
                                    //print("${snapshot.data[index].index}");
                                    //var mov = snapshot.data[index];

                                    //Navigator.of(context).pop();
                                    //Navigator.popUntil(context);
                                    Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (Route<dynamic> route) => false);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailPage(movieObj: snapshot.data[index],index: snapshot.data[index].index)));

                                  },
                                
                              ),
                            ),
                            height: 230,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                              image: new DecorationImage(
                                image: NetworkImage(snapshot.data[index].img),
                                fit: BoxFit.cover,
                              ),
                            ),
                            
                          ),
                           ),
                          
                          Center( 
                            child: Container(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                            height: 30,
                            width: 200,
                            child: new Text(snapshot.data[index].title,
                              style: new TextStyle(
                                fontFamily: 'FrontPage',
                                fontSize: 18.0,
                                color: Colors.black87, 
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ),
                        ],
                      ),
                      
                    );
                  },
                ),
              );
            }
          } else {
            //show temporary solution
            return new Container(
              color: Colors.white,
              child: Center(
                widthFactor: 100.0,
                heightFactor: 100.0,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                ),
              ),
            );
          }
        });
  }
}

Future<List<VideoObj>> _fetchFutureData() async {
  var data = await http.get("http://192.168.1.15:8200/api/values");
  var jsonData = json.decode(data.body);
  //print(""+jsonData);

  List<VideoObj> vids = [];

  for (var v in jsonData) {
    VideoObj video = VideoObj(v["Id"], v["Name"], v["imgLink"], v["pageLink"]);
    vids.add(video);
  }

 // print(vids.length);
  return vids;
}

class VideoObj {
  final int index;
  final String title;
  final String img;
  final String link;

  VideoObj(this.index, this.title, this.img, this.link);
}
