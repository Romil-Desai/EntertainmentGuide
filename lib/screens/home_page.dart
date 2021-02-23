import 'package:entertainmentguide/model/console.dart';
import 'package:entertainmentguide/model/entity.dart';
import 'package:entertainmentguide/screens/search_page.dart';
import 'package:entertainmentguide/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../contants.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool showLoading = true;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.005),
          child: Text(
            'GUIDE',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 30.0,
                color: Colors.black,
                letterSpacing: 1.0),
          ),
        ),
        shadowColor: Colors.white,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: IconButton(
                icon: Hero(
                  tag: 'icon',
                  child: Icon(
                    Icons.search,
                    size: 30.0,
                    color: searchBarContentColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                }),
          )
        ],
      ),
      body: Column(
        children: [
          HomePageTile("MOVIES", popularmovies),
          HomePageTile("TV SERIES", popularseries)
        ],
      ),
    );
  }
}
