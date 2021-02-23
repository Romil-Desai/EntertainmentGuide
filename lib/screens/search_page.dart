import 'package:entertainmentguide/contants.dart';
import 'package:entertainmentguide/model/console.dart';
import 'package:entertainmentguide/model/entity.dart';
import 'package:entertainmentguide/screens/movie_screen.dart';
import 'package:entertainmentguide/screens/test.dart';
import 'package:entertainmentguide/screens/testscrren.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String search_value;
  List<MovieListTile> movielist;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    print(movielist == null ? 0 : movielist.length);
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0, horizontal: width * 0.07),
              child: Container(
                height: 50.0,
                child: TextField(
                  style: TextStyle(fontSize: 20.0),
                  onChanged: (value) {
                    search_value = value;
                  },
                  onSubmitted: (search_value) async {
                    //function called when the user presses submit button on keyboard
                    ImdbHelper imdbHelper =
                        ImdbHelper(searchquery: search_value);
                    List<MovieListTile> temp = await imdbHelper.getMovielist();
                    setState(() {
                      movielist = temp;
                    });
                  },
                  decoration: searchBarDecoration,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: movielist == null ? 0 : movielist.length,
                  itemBuilder: (context, index) {
                    print(movielist.length);
                    return MovieBox(
                        imageUrl: movielist[index].imgUrl,
                        title: movielist[index].title,
                        description: movielist[index].description,
                        onclick: () async {
                          ImdbHelper imdbHelper =
                              ImdbHelper(searchquery: movielist[index].id);
                          Movie movie = await imdbHelper.getMovieDetails();
                          print(movie.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieScreen(movie)));
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
