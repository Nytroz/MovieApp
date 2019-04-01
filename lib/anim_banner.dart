import 'package:flutter/material.dart';
import 'package:loginfirebaseexample/system/moviedb_controller.dart';
import 'package:loginfirebaseexample/trailer_page.dart';
import 'package:url_launcher/url_launcher.dart';


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

    double trailerY=1.2;
    double trailerX;
    double oValue = 0;


    double opacityLevel = 0.0;
    void _changeOpacity() {
      opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
    }


    void _trailerButtonChange() {
      //trailerY=0.95;
      if (trailerY == 1.2){
        trailerY = 0.95;
        oValue =1;
      }else{
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

    trailerX=0;
    trailerY=1.2;




    return AnimatedBuilder(
      animation: _animationController,
      child: Container(
        //margin: EdgeInsetsDirectional.only(bottom: 10),
        //decoration: BoxDecoration(border: BorderDirectional(bottom: BorderSide(width: 20,color: Colors.black))),



          //color: Colors.white,
          ),
      builder: (context, child) {
        v = (_animationController.value * 100).toInt();


        if (img == null) {
          _imageChange();
        }

        if (oldV != v) {
          //print(v);
          oldV = v;
          if (v == 0) {
            _changeOpacity();
          }

          //if(v == 10){
          //  _trailerButtonChange();
          //}

          if (v == 90) {
            _changeOpacity();
            _trailerButtonChange();
          }
          if (v == 99) {
            _imageChange();
          }
        }





        return Container(
          //margin: EdgeInsetsDirectional.only(bottom: 10),
          //decoration: BoxDecoration(border: BorderDirectional(bottom: BorderSide(width: 20,color: Colors.red))),

          //padding: EdgeInsets.only(bottom: 20.0),
          //child: Image.network(list[0].getPoster()),
          child: Stack(
            children: <Widget>[
              AnimatedOpacity(
                opacity: opacityLevel,
                duration: Duration(seconds: 1),
                curve: Curves.ease,
                child: Container(
                  //color: Colors.black,
                  //margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    //border: BorderDirectional(bottom: BorderSide(width: 100,color: Colors.black)),

                    image: DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              /*
              Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors:  [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255-(v*2.5).toInt(), 255, 255, 255),Color.fromARGB(0, 255, 255, 255),Color.fromARGB(0, 255, 255, 255)],
                      tileMode: TileMode.clamp,
                    ),
                    //border: Border.all(width: 40,color: Colors.white),
                  ),
              ),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors:  [Color.fromARGB(200-(v*2).toInt(), 255, 255, 255),Color.fromARGB(100-(v).toInt(), 255, 255, 255)],
                    tileMode: TileMode.clamp,
                  ),
                  //border: Border.all(width: 40,color: Colors.white),
                ),
              ),
              */
              AnimatedContainer(
              duration: Duration(seconds: 1),
                //alignment: FractionalOffset.fromOffsetAndSize(Offset(0.0, animation.value), Size(2000, animation.value)),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                //border: Border(bottom: BorderSide(width: 10.0,color: Colors.white)),
                  //border: BorderDirectional(bottom: BorderSide(width: 20,color: Colors.red)),

                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,//Alignment(0.0, animation.value),
                    end: Alignment.topCenter,
                    colors:  [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(0, 255, 255, 255)],
                    stops: [0,0+animation.value],
                    tileMode: TileMode.clamp,
                  ),
                  //border: Border.all(width: 40,color: Colors.white),
                ),
              ),



              AnimatedAlign(
                duration: Duration(seconds: 2),
                alignment: Alignment(trailerX, trailerY),
                curve: Curves.ease,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: oValue,
                  curve: Curves.easeInOut,
                  child: FlatButton(
                        onPressed: (){

                          //   _launch(.movieObj.link);



                          //Navigator.push(context, MaterialPageRoute(builder: (context) => MovieTrailerPage()));

                        },
                        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),side: BorderSide(width: 1.5,color: Colors.black)),
                        splashColor: Colors.redAccent,


                        child: AnimatedContainer(
                        //transform: Matrix4.diagonal3Values(1, 1, 1),
                        alignment: Alignment.center,
                        height: 10,
                        width: 90,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeInOut,
                        child: new Text("Watch Trailer" , style: TextStyle(color: Colors.black,fontSize: 12)),

                    ),
                  ),
                ),
              ),



            ],
          ),
        );
      },
    );



    //Image.network(list[0].getPoster());
  }

  void  _launch (String urlString) async{
    if(await canLaunch(urlString)){
      await launch(urlString);
    }else{
      throw 'Could not launch';
    }
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
