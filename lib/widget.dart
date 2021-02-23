import 'package:entertainmentguide/model/entity.dart';
import 'package:entertainmentguide/screens/movie_screen.dart';
import 'package:flutter/material.dart';

import 'model/console.dart';

class CastContainer extends StatelessWidget {
  CastMember castMember;

  CastContainer(this.castMember);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.25,
      height: height * 0.30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.20,
            width: width * 0.25,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
            ),
            child: Image(
              image: NetworkImage(
                castMember.imageUrl,
              ),
              fit: BoxFit.fill,
            ),
          ),
          Text(
            castMember.firstName,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: castMember.firstName.length > 9 ? 10.0 : 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            castMember.lastName,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: castMember.lastName.length > 9 ? 15.0 : 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          Container(
            width: width,
            child: Text(
              "as ${castMember.characterPlayed.split(" ")[0]}",
              textAlign: TextAlign.left,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CastList {
  List cast;
  var width;
  List<Widget> castMemberList = [];

  CastList(this.cast, this.width);
  List<Widget> getList() {
    for (var castMember in cast) {
      castMemberList.add(CastContainer(castMember));
      castMemberList.add(SizedBox(width: width));
    }
    return castMemberList;
  }
}

class GenreList {
  List genres;
  List<GenreContainer> genreList = [];

  GenreList(this.genres);

  List<GenreContainer> getGenres() {
    for (String genre in genres) {
      genreList.add(GenreContainer(genre));
    }
    return genreList;
  }
}

class GenreContainer extends StatelessWidget {
  String genre;

  GenreContainer(this.genre);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(genre,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class HomePageTile extends StatefulWidget {
  String title;
  String url;

  HomePageTile(this.title, this.url);

  @override
  _HomePageTileState createState() => _HomePageTileState();
}

class _HomePageTileState extends State<HomePageTile> {
  var listofcustomtile;

  Future<List<CustomTile>> getlist() async {
    return await ImdbHelper.getPopulars(widget.url);
  }

  @override
  void initState() {
    // This is the proper place to make the async calls
    // This way they only get called once

    // During development, if you change this code,
    // you will need to do a full restart instead of just a hot reload

    // You can't use async/await here, because
    // We can't mark this method as async because of the @override
    // You could also make and call an async method that does the following
    getlist().then((result) {
      // If we need to rebuild the widget with the resulting data,
      // make sure to use `setState`
      setState(() {
        listofcustomtile = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (listofcustomtile == null) {
      return Container();
    }
    return Container(
      width: width,
      height: height * 0.42,
      margin: EdgeInsets.only(top: height * 0.005, left: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.03),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Row(
              children: [
                Text(
                  'Popular',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(
                            left: width * 0.02, right: width * 0.3),
                        child: Divider(color: Colors.black))),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.01),
                  child: Text(
                    'See all >',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return MovieTile(
                imgurl: listofcustomtile[index].imgUrl,
                imdbrating: listofcustomtile[index].rating,
                title: listofcustomtile[index].title,
                onclicked: () async {
                  ImdbHelper imdbHelper =
                      ImdbHelper(searchquery: listofcustomtile[index].id);
                  Movie movie = await imdbHelper.getMovieDetails();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieScreen(movie)));
                },
              );
            },
            scrollDirection: Axis.horizontal,
          ))
        ],
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  String imgurl;
  String title;
  String imdbrating;
  Function onclicked;

  MovieTile({this.imgurl, this.title, this.imdbrating, this.onclicked});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FlatButton(
      onPressed: onclicked,
      child: Container(
        width: width * 0.22,
        height: height * 0.26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.18,
              width: width * 0.22,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                    image: NetworkImage(
                      imgurl,
                    ),
                    fit: BoxFit.fill,
                  )),
            ),
            SizedBox(
              height: height * 0.005,
            ),
            Container(
              width: width * 0.22,
              height: height * 0.04,
              child: Text(title.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            ),
            Row(
              children: [
                Icon(
                  Icons.star_rate_sharp,
                  color: Color(0xffF5C518),
                ),
                Text(imdbrating,
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// SingleChildScrollView(
// scrollDirection: Axis.horizontal,
// child: Padding(
// padding:
// EdgeInsets.only(left: width * 0.03, top: height * 0.02),
// child: Row(
// children: [
// MovieTile(),
// MovieTile(),
// MovieTile(),
// MovieTile(),
// MovieTile(),
// MovieTile()
// ],
// ),
// ),
// ),
