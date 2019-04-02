import 'package:loginfirebaseexample/CategoryBarBuilder.dart';
import 'package:loginfirebaseexample/anim_banner.dart';
import 'package:loginfirebaseexample/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebaseexample/search_page.dart';
import 'package:loginfirebaseexample/system/DataWidget.dart';
import 'DataFetchController.dart';
import 'movie_page.dart';
import 'package:loginfirebaseexample/system/moviedb_controller.dart';
import 'package:async/async.dart';

class HomePage extends StatefulWidget {
  HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => _HomePage(onSignedOut: this.onSignedOut);
}

class _HomePage extends State<HomePage> {
  _HomePage({this.onSignedOut});

  final VoidCallback onSignedOut;
  var videos;
  var netImg;
  var butCol = Colors.blue;

  final AsyncMemoizer<List<DbMovieObj>> _memoizer = AsyncMemoizer();

  void actionfunc() {
    butCol = Colors.red;
    setState(() {});
  }

  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    searchDebug();
  }

  void searchDebug() {
    MovieDBController().searchMovie("robin");
  }

  Future<List<DbMovieObj>> fetchList() async {
    var vidlist = await MovieDBController()
        .discoverRequest(SortBy.popularity, SortTypes.asc);
    for (var v in vidlist) {}
        return _memoizer.runOnce(() async {
        await Future.delayed(Duration(seconds: 1));
        return vidlist;
    });
  }

  bool pressedSearch = false;
  static Widget _appBarTitle = new Text('Search Movies');

  Widget sliverSearchBar() {
    if (pressedSearch == false) {
      return SliverAppBar(
        pinned: true,
        title: _appBarTitle,
        expandedHeight: 10,
        elevation: 0,
        forceElevated: true,
        leading: FlatButton(
            onPressed: () {
              setState(() {
                pressedSearch = true;
              });
            },
            child: Icon(Icons.search)),
      );
    } else  {
      return SliverAppBar(
        pinned: true,
        //title: new Text("........."),
        expandedHeight: 500,
        elevation: 10,
        forceElevated: true,
        automaticallyImplyLeading: false,
        leading: FlatButton(
            onPressed: () {
              setState(() {
                pressedSearch = false;
              });
            },
            child: Icon(
              Icons.cancel,
              color: Colors.white,
            )),

        //search page content widget wrapper
        flexibleSpace: SearchPage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: Theme.of(context),
      routes: <String, WidgetBuilder>{
        "/HomePage": (BuildContext context) => new HomePage(),
        "/MovieDetailPage": (BuildContext context) => new MovieDetailPage(),
      },
      home: SafeArea(
        top: false,
        child: new Scaffold(
          drawer: new Container(
            width: 200.0,
            color: Theme.of(context).primaryColor, 
            child: new FlatButton(
              child: new Text(" Log Out "),
              onPressed: () => _signOut(context),
            ),
          ),
          body: Container(
            color: Theme.of(context).primaryColor,
            child: new CustomScrollView(
              slivers: <Widget>[
                FutureBuilder(
                  future: fetchList(),
                  builder: (context, snapshot) {
                    print("Builds banner");
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null &&
                        pressedSearch == false) {
                      return SliverAppBar(
                        backgroundColor: Colors.white,
                        expandedHeight: 650.0,
                        pinned: false,
                        primary: false,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: AnimatedBannerStack(snapshot.data),
                        ),
                      );
                    } else {
                      return SliverAppBar(
                        primary: false,
                        pinned: false,
                        backgroundColor: Colors.white,
                        expandedHeight: 0.0,
                        flexibleSpace: new FlexibleSpaceBar(
                        ),
                      );
                    }
                  },
                ),
                sliverSearchBar(),
                SliverList(
                  delegate: SliverChildListDelegate([
                    CategoryBarBuilder(category: 'Action', expand: false),
                    CategoryBarBuilder(category: 'Drama', expand: false),
                    CategoryBarBuilder(category: 'thriller', expand: false),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("disposing home page state");
    super.dispose();
  }
}
