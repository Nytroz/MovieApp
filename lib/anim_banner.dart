import 'package:flutter/material.dart';
import 'package:loginfirebaseexample/system/moviedb_controller.dart';

class AnimatedBannerStack extends StatefulWidget {
  final List<DbMovieObj> list;

  AnimatedBannerStack(this.list);

  @override
  _AnimatedBannerStackState createState() => _AnimatedBannerStackState(list);
}

class _AnimatedBannerStackState extends State<AnimatedBannerStack>
  with SingleTickerProviderStateMixin {
  _AnimatedBannerStackState(this.list);
  AnimationController _animationController;
  Animation animation, transformationAnim;

  var duration = Duration(seconds: 8);

  final List<DbMovieObj> list;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: duration,
      vsync: this,
    )..repeat();
    _animationController.repeat();
    print("started");

    animation = Tween(begin: 0.0, end: 0.7).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    int v;
    int oldV;
    int rotIndex = 0;
    String img;
    double trailerY = 1.2;
    double trailerX;
    double oValue = 0;
    double opacityLevel = 0.0;
    
    void _changeOpacity() {
      opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
    }

    void _trailerButtonChange() {
      if (trailerY == 1.2) {
        trailerY = 0.95;
        oValue = 1;
      } else {
        trailerY = 1.2;
        oValue = 0;
      }
    }

    void _imageChange() {
      if (rotIndex < list.length - 1) {
        rotIndex += 1;
        if (list[rotIndex].getPoster() != null) {
          img = list[rotIndex].getPoster();
          _trailerButtonChange();
        } else {
          rotIndex += 1;
          return;
        }
      } else {
        rotIndex = 0;
      }
    }

    trailerX = 0;
    trailerY = 1.2;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        v = (_animationController.value * 100).toInt();

        if (img == null) {
          _imageChange();
        }

        if (oldV != v) {
          oldV = v;
          if (v == 0) {
            _changeOpacity();
          }
          if (v == 90) {
            _changeOpacity();
            _trailerButtonChange();
          }
          if (v == 99) {
            _imageChange();
          }
        }

        return Container(
          child: Stack(
            children: <Widget>[
              AnimatedOpacity(
                opacity: opacityLevel,
                duration: Duration(seconds: 1),
                curve: Curves.ease,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              
              AnimatedContainer(
                duration: Duration(seconds: 1),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment
                        .bottomCenter, //Alignment(0.0, animation.value),
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(0, 255, 255, 255)
                    ],
                    stops: [0,0.3],
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
              AnimatedAlign(
                duration: Duration(seconds: 2),
                alignment: Alignment(trailerX, trailerY),
                curve: Curves.ease,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: oValue,
                  curve: Curves.easeInOut,
                  child: FlatButton(
                    onPressed: () {
                      //   _launch(.movieObj.link);

                      //Navigator.push(context, MaterialPageRoute(builder: (context) => MovieTrailerPage()));
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(width: 1.5, color: Colors.black)),
                    splashColor: Colors.redAccent,
                    child: AnimatedContainer(
                      //transform: Matrix4.diagonal3Values(1, 1, 1),
                      alignment: Alignment.center,
                      height: 10,
                      width: 90,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      child: new Text("Watch Trailer",
                          style: TextStyle(color: Colors.black, fontSize: 12)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    print("Disposes banner");
    //_animationController.reset();
    //this.list.clear();

    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }
}
