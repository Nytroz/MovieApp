import 'package:flutter/material.dart';

class DataWidget extends InheritedWidget {
DataWidget({Key key,@required Widget child,this.pressedSearch,}): super(key: key, child: child);

bool pressedSearch;

void InvertPressed(){
  pressedSearch != pressedSearch;
}

static DataWidget of(BuildContext context) {
return context.inheritFromWidgetOfExactType(DataWidget) as DataWidget;
}

@override
bool updateShouldNotify(DataWidget oldWidget) => pressedSearch != oldWidget.pressedSearch;
}