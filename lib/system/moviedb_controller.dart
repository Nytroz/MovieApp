
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


///Categories to search by
enum SortBy {
  popularity,
  release_date,
  revenue,
  primary_release_date,
  original_title,
  vote_avarage,
  vote_count,
}

enum SortTypes { asc, desc }

class MovieDBController {
  final apiKey = '78abd1fa93e1c191684953e35b765557';
  var discoverData;
  var searchData;
  var baseUrl = '';

  Future<List<DbMovieObj>> searchMovie(String keyword) async { //Search specific movies based on name
    var query = keyword;
    /// https://api.themoviedb.org/3/search/multi?api_key=78abd1fa93e1c191684953e35b765557&language=en-US&page=1&include_adult=false&query=aquaman
    var url = "https://api.themoviedb.org/3/search/multi?api_key=$apiKey"+"&language=en-US&page=1&include_adult=false&query=$query";

    searchData = await http.get(url);
    var jsonData = json.decode(searchData.body);
    var selectionJson = jsonData["results"];
    print(selectionJson);

    List<DbMovieObj> vids = [];

    for (var v in selectionJson) {
      DbMovieObj video = DbMovieObj(v["id"], v["original_title"], v["poster_path"], v["overview"]);
/*
      if (v["original_title"] != null) {
        vids.add(video);
        print("added: " +v["original_title"]);
      } else {
        print(v["original_title"] + " could not be added.");
      }
      */
      vids.add(video);
    }


    return vids;
  }

  List<String> sorter = [];


  ///func to discover trending movies of the week
  Future<List<DbMovieObj>> discoverRequest(SortBy sortBy, SortTypes sortTypes) async {
    //---------------------------------------------------------
    //this will compose the sorting attributes in desired ways

    sorter.add("" + sortBy.toString().split('.')[1]);
    sorter.add(".");
    sorter.add("" + sortTypes.toString().split('.')[1]);

    var sortType = (combine) => sorter.toString();

    var url = "https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey";

    discoverData = await http.get(url);
    var jsonData = json.decode(discoverData.body);
    var selectionJson = jsonData["results"];

    print(selectionJson);



    List<DbMovieObj> vids = [];
    for (var v in selectionJson) {
      DbMovieObj video = DbMovieObj(v["id"], v["original_title"], v["poster_path"], v["overview"]);


        if (v["poster_path"] != null) {
          vids.add(video);
          print(v["original_title"]);
        } else {
          print(v["original_title"] + " could not be added.");
        }
      //vids.add(video);


    }

    return vids;
  }



  void find() async {
    //print("FIND REQUEST");
  }
}

class DbMovieObj {
  final int id;
  final String originaltitle;
  final String posterpath;
  final String overview;
  final String releasedate;

  DbMovieObj(this.id, this.originaltitle, this.posterpath, this.overview, {this.releasedate});

  String getPoster() {
    //print(posterpath);

    var finalPosterPath;
    String size = "original";
    var testedPath;
    //change based on demands

    //print(finalPosterPath);
    try {
      finalPosterPath = "https://image.tmdb.org/t/p/" + size + posterpath;
      testedPath = finalPosterPath;
    } catch (e) {
      print('could not load image');
      //testedPath = 'exception';

      print(id);
      testedPath = 'http://www.gsfdcy.com/data/img1/91/2209629-tv-wallpaper.jpg';
    }
    //var exeption = Image.network(finalPosterPath);

    return testedPath;
  }

  String getTrailer({String size, String}) {
    var finalPath;
    //change based on demands
    return finalPath;
  }
}
