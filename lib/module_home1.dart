import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';



class LoggedInMain extends State<StatefulWidget> {
  var _isLoading = true;
  var videos;

  Future<List<VideoObj>> _fetchFutureData() async {
    var data = await http.get("http://77.174.196.4:8200/api/values");
    var jsonData = json.decode(data.body);

    List<VideoObj> vids = [];

    for (var v in jsonData) {
      VideoObj video =
      VideoObj(v["Id"], v["Name"], v["imgLink"], v["pageLink"]);
      vids.add(video);
    }

    //print(vids.length);
    return vids;
  }

  @override
  Widget build(BuildContext context) {

      new Scaffold(
        //body: _isLoading ? _LoadScreen : _customView,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              flexibleSpace: new FlexibleSpaceBar(
                background: new Image.network(
                    'http://www.gsfdcy.com/data/img1/91/2209629-tv-wallpaper.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                childAspectRatio: 0.75,
              ),
              delegate: new SliverChildBuilderDelegate(
                    (context, index) {
                  return new Column(
                    children: <Widget>[
                      Container(
                        child: FutureBuilder(
                            future: _fetchFutureData(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return _LoadScreen;
                              }

                              return new ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return new Container(
                                    height: 200,
                                    width: 200,
                                    child: new Text(snapshot.data[index].title),
                                    color: Colors.deepPurple,
                                  );
                                },
                              );
                            }),
                      ),
                      Container(
                        margin: new EdgeInsets.all(5.0),
                        color: Colors.grey,
                        height: 50,
                        width: 200,
                      ),
                    ],
                  );
                },
                //childCount: 10,
              ),
            ),
          ],
        ),
        //drawer: _drawerContent,

    );
  }

  var _LoadScreen = new Container(
    alignment: Alignment.center,
    width: 200,
    height: 200,
    child: new CircularProgressIndicator(),
  );

  var _drawerContent = new Drawer(
    elevation: 8,
  );

  _fetchData() async {
    //print("Attempting to fetch data from network");
    final url = "http://192.168.1.15:8200/api/values";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //print(response.body);
      final map = json.decode(response.body);

      setState(() {
        _isLoading = false;
        this.videos = map;
      });
    }
    //print(response);
  }
}

class VideoObj {
  final int index;
  final String title;
  final String img;
  final String link;

  VideoObj(this.index, this.title, this.img, this.link);
}
