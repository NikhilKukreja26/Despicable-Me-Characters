import 'package:despicable_me_characters/models/character.dart';
import 'package:flutter/material.dart';

import '../styleguide.dart';
import '../widgets/character_widget.dart';

class CharacterListingScreen extends StatefulWidget {
  @override
  _CharacterListingScreenState createState() => _CharacterListingScreenState();
}

class _CharacterListingScreenState extends State<CharacterListingScreen> {
  PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: currentPage,
      keepPage: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 32.0, top: 8.0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(text: 'Despicable Me', style: AppTheme.display1),
                      TextSpan(text: '\n'),
                      TextSpan(text: 'Characters', style: AppTheme.display2),
                    ]),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      for (var i = 0; i < characters.length; i++)
                        CharacterWidget(
                          character: characters[i],
                          pageController: _pageController,
                          currentPage: i,
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
