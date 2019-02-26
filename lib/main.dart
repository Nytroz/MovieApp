import 'package:flutter/material.dart';
import 'package:loginfirebaseexample/auth_provider.dart';
import 'package:loginfirebaseexample/system/DataWidget.dart';
import 'auth.dart';
import 'root_page.dart';

void main(){
  runApp(new MyApp());
}

final ThemeData _themeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.orange,
  accentColor: Colors.deepOrange,
  primaryColor: Colors.white,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: DataWidget(
        key: Key("pressed"),
        pressedSearch: false,
        child: MaterialApp(
          title: 'flutter login example',
          theme: _themeData,

          home: new RootPage()
        ),
      ),
    );
  }
}