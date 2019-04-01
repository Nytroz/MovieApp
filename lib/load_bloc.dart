import 'dart:async';
import 'load_event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class LoadBloc{
  var _mapData;

  final _loadStateController = StreamController <List<VideoObj>>();

  StreamSink<List<VideoObj>> get _inMapData => _loadStateController.sink;
  // For state, exposing only a stream which outputs data
  Stream<List<VideoObj>> get MapData => _loadStateController.stream;

  final _loadEventController = StreamController<LoadEvent>();
  // For events, exposing only a sink which is an input
  Sink<LoadEvent> get loadEventSink => _loadEventController.sink;


  LoadBloc(){
    _loadEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(LoadEvent event){
    if(event is LoadJson) {
      //var _fetchFutureData();
      _mapData = _fetchFutureData();

    }
    _inMapData.add(_mapData);
  }
}

Future<List<VideoObj>> _fetchFutureData() async {
  var data = await http.get("http://192.168.1.15:8200/api/values");
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

class VideoObj {
  final int index;
  final String title;
  final String img;
  final String link;

  VideoObj(this.index, this.title, this.img, this.link);
}