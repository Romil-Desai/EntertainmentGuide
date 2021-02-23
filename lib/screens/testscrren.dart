import 'package:entertainmentguide/model/entity.dart';
import 'package:flutter/material.dart';
import 'package:entertainmentguide/widget.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

import 'package:url_launcher/url_launcher.dart';

class TestScreen extends StatefulWidget {
  Movie movieDetails;

  TestScreen(this.movieDetails);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<GenreContainer> genrelist;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _errorkey = new GlobalKey<ScaffoldState>();
    GenreList genreList = GenreList(widget.movieDetails.genres);
    genrelist = genreList.getGenres();
    return Scaffold(
      key: _errorkey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ),
      body: ColumnSuper(
        innerDistance: -20,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(widget.movieDetails.imgUrl),
            )),
            height: height * 0.65,
            width: double.infinity,
            child: Center(
              child: FlatButton(
                padding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                color: Color(0xffff0000),
                onPressed: () async {
                  var url = widget.movieDetails.youtubeTrailerLink;
                  if (url == "") {}
                  print(url);
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    _errorkey.currentState.showSnackBar(
                      SnackBar(
                        content: new Text('Trailer not found'),
                        duration: new Duration(seconds: 5),
                      ),
                    );
                    print("error");
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.play_arrow_outlined,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
          ),
          Container(
            height: height * 0.50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Text(
                        'ImDb Rating:',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.0),
                      ),
                      Icon(
                        Icons.star_rate_sharp,
                        color: Color(0xffF5C518),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Text("${widget.movieDetails.imdbRating}/10.0",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.8,
                    child: Text(widget.movieDetails.name,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: widget.movieDetails.name.length > 15
                                ? 20.0
                                : 30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0)),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: genrelist,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.9,
                    child: Text(widget.movieDetails.description,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20.0,
                          height: 1.3,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
