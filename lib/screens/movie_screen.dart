import 'package:entertainmentguide/model/entity.dart';
import 'package:entertainmentguide/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class MovieScreen extends StatelessWidget {
  Movie movieDetails;
  List<GenreContainer> genrelist;
  MovieScreen(this.movieDetails);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _errorkey = new GlobalKey<ScaffoldState>();
    GenreList genreList = GenreList(movieDetails.genres);
    List<GenreContainer> genrelist = genreList.getGenres();
    return Scaffold(
      key: _errorkey,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
          ),
          Container(
            width: double.infinity,
            height: height * 0.57,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    movieDetails.imgUrl,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: height * 0.05,
            child: FlatButton(
              color: Color(0xffFC6917),
              shape: CircleBorder(),
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
          Positioned(
            top: height * 0.5,
            right: width * 0.10,
            child: FlatButton(
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              color: Color(0xffFC6917),
              onPressed: () async {
                var url = movieDetails.youtubeTrailerLink;
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
          Positioned(
              top: height * 0.58,
              height: height * 0.44,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.02, horizontal: width * 0.03),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text("${movieDetails.imdbRating}/10.0",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        width: width * 0.8,
                        child: Text(movieDetails.name,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0)),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Row(
                        children: genrelist,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          Icon(Icons.live_tv),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            movieDetails.runtime,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        width: width * 0.9,
                        child: Text(movieDetails.description,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            maxLines: 35,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 1.3,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Cast',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Container(
                        width: width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: CastList(
                                            movieDetails.castList, width * 0.01)
                                        .getList() ==
                                    null
                                ? []
                                : CastList(movieDetails.castList, width * 0.01)
                                    .getList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

// appBar: AppBar(
// leading: FlatButton(
// onPressed: () {
// Navigator.pop(context);
// },
// child: Icon(
// Icons.arrow_back_ios,
// size: 50.0,
// ),
// ),
// backgroundColor: Colors.transparent,
// // actions: [
// //
// // ],
// ),
// body: Column(
// children: [
// Expanded(
// flex: 1,
// child: Container(
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage(
// "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5"
// "BanBnXkFtZTcwNTI5OTM0Mw@@._V1_Ratio0.6791_AL_.jpg"),
// ),
// ),
// ),
// )
// ],
// // ),
// Text(movieDetails.runtime,
// style: TextStyle(
// fontSize: 15.0, fontWeight: FontWeight.w600))
