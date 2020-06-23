import 'package:after_layout/after_layout.dart';
import 'package:despicable_me_characters/styleguide.dart';
import 'package:flutter/material.dart';

import '../models/character.dart';

class CharacterDetailScreen extends StatefulWidget {
  final double _expandedBottomSheetBottomPosition = 0;
  final double _collapsedBottomSheetBottomPosition = -250;
  final double _completeCollapsedBottomSheetBottomPosition = -330;
  final Character character;

  const CharacterDetailScreen({Key key, this.character}) : super(key: key);

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen>
    with AfterLayoutMixin<CharacterDetailScreen> {
  double _bottomSheetBottomPosition = -330;
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: 'background-${widget.character.name}',
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: widget.character.colors,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 40.0,
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 40.0,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  onPressed: () {
                    setState(() {
                      _bottomSheetBottomPosition =
                          widget._completeCollapsedBottomSheetBottomPosition;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                    tag: 'image-${widget.character.name}',
                    child: Image.asset(
                      widget.character.imagePath,
                      height: screenHeight * 0.45,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 8.0,
                      ),
                      child: Hero(
                        tag: 'name-${widget.character.name}',
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            child: Text(
                              widget.character.name,
                              style: AppTheme.heading,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 8.0, 32.0),
                      child: Text(
                        widget.character.description,
                        style: AppTheme.subHeading,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            bottom: _bottomSheetBottomPosition,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: _onTap,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      height: 80,
                      child: Text(
                        "Clips",
                        style:
                            AppTheme.subHeading.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _clipsWidget(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onTap() {
    setState(() {
      _bottomSheetBottomPosition = isCollapsed
          ? widget._expandedBottomSheetBottomPosition
          : widget._collapsedBottomSheetBottomPosition;
      isCollapsed = !isCollapsed;
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isCollapsed = true;
        _bottomSheetBottomPosition = widget._collapsedBottomSheetBottomPosition;
      });
    });
  }
}

Widget _clipsWidget() {
  return Container(
    height: 250,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            roundedContainer(Colors.redAccent),
            SizedBox(height: 20),
            roundedContainer(Colors.greenAccent),
          ],
        ),
        SizedBox(width: 16),
        Column(
          children: <Widget>[
            roundedContainer(Colors.orangeAccent),
            SizedBox(height: 20),
            roundedContainer(Colors.purple),
          ],
        ),
        SizedBox(width: 16),
        Column(
          children: <Widget>[
            roundedContainer(Colors.grey),
            SizedBox(height: 20),
            roundedContainer(Colors.blueGrey),
          ],
        ),
        SizedBox(width: 16),
        Column(
          children: <Widget>[
            roundedContainer(Colors.lightGreenAccent),
            SizedBox(height: 20),
            roundedContainer(Colors.pinkAccent),
          ],
        ),
      ],
    ),
  );
}

Widget roundedContainer(Color color) {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
}
