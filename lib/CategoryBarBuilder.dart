import 'package:flutter/material.dart';


class CategoryBarBuilder extends StatefulWidget {

  CategoryBarBuilder({this.expand = false, this.category,this.child});

  final String category;

  final Widget child;
  final bool expand;


  @override
  _CategoryBarBuilder createState() => _CategoryBarBuilder(category);
}


class _CategoryBarBuilder extends State<CategoryBarBuilder> with SingleTickerProviderStateMixin{

  _CategoryBarBuilder(this.category);
  final String category;

  var expanded;
  Icon clickableIcon;

  AnimationController expandController;
  Animation<double> animation;

  void initState() {
    super.initState();
    prepareAnimations();
    clickableIcon = Icon(Icons.keyboard_arrow_down);
  }



  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500)
    );
    Animation curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {

        });
      }
      );
  }

  @override
  void didUpdateWidget(CategoryBarBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.expand) {
      expandController.forward();
    }
    else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  //width: 50,
                  constraints: BoxConstraints.tight(Size(50, 50)),

                  child: FlatButton(

                    onPressed: (){
                      if(expanded == false) {
                        setState(() {
                          clickableIcon = Icon(Icons.keyboard_arrow_up);
                          expandController.forward();
                          expanded = true;
                        });
                      }else{
                        setState(() {
                          clickableIcon = Icon(Icons.keyboard_arrow_down);
                          expandController.reverse();
                          expanded = false;
                        });
                      }
                    } ,
                    child: clickableIcon,
                  ),
                ),
                 Container(
                    child: Text("Category: " + category,style: TextStyle(color: Colors.black,fontSize: 20))
                 ),
              ],
            ),
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Container(
              height: 300,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

}
