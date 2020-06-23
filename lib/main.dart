import 'package:flutter/material.dart';

import './pages/characters_listing_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Despicable Me Charchters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        canvasColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Colors.white,
        ),
      ),
      home: CharacterListingScreen(),
    );
  }
}
