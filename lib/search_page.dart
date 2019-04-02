import 'package:flutter/material.dart';
import 'package:loginfirebaseexample/system/moviedb_controller.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage>{

  _SearchPage() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = new List(); // names we get from API
  //List<List<DbMovieObj>> filteredList = new List<List<DbMovieObj>>();
  List<DbMovieObj> filteredList = new List<DbMovieObj>(); // names filtered by search text

  //double dynamicHeight = 500;
  /// adds the search keyword from the user into the api request to get a corresponding list of video objects with their data
  Future<List<DbMovieObj>> getSearch(String query) async{
    print("seaching1");
    var vidList;
    vidList = await MovieDBController().searchMovie(query);
    print("seaching2");
    return vidList;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 30),
      color: Colors.blueGrey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded (
                  child: Container(
                    padding: EdgeInsets.only(left: 50,right: 50),
                    child: TextField(
                      controller: _filter,
                      decoration: new InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.white),
                        prefixStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              //height: 5000,
              //color: Colors.grey,
              child:  FutureBuilder(
                // build listview from here based on letters in searchfield (send them to a new db search future that returns api data)
                future:  getSearch(_searchText), 
                builder: (context, snapshot) {
                    if (snapshot.data != null){
                        List<DbMovieObj> tempList = new List<DbMovieObj>();
                        for (int i = 0; i < snapshot.data.length; i++) {

                          if(snapshot.data[i].originaltitle != null) {
                              tempList.add(snapshot.data[i]);
                          }
                        }
                        filteredList = tempList;

                        return Container(
                        padding: EdgeInsets.all(10),
                        //child: new Text("" + snapshot.data[0].originaltitle),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredList.length,
                            itemBuilder: (context, int index){
                              return Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(5),
                                //height: 50,
                                //width: 300,
                                color: Colors.grey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      width: 200,
                                      height: 300,
                                      child: Image.network(filteredList[index].getPoster(),fit: BoxFit.fitWidth),
                                    ),
                                    Text(filteredList[index].originaltitle,style: TextStyle(color: Colors.white ,fontSize: 18)),
                                  ],
                                ),
                              );
                            },
                        ),
                      ); //this needs to contain somekind of listview
                    }
                    else{
                      return Container(
                        child: Center(
                          child: new Text("Nothing found."),
                        ),
                      ); //this will need to contain a background.. or a loading circle
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
