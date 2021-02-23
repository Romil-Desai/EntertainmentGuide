import 'package:entertainmentguide/model/NetworkHelper.dart';
import 'package:entertainmentguide/contants.dart';
import 'package:entertainmentguide/model/entity.dart';

class ImdbHelper {
  String searchquery = "";

  ImdbHelper({this.searchquery});

  Future<List<MovieListTile>> getMovielist() async {
    List<MovieListTile> movieList = [];
    NetworkHelper networkHelper = NetworkHelper(url: "$filmList$searchquery");
    var listData = await networkHelper.getData();
    dynamic listOfResults = listData["results"];
    if (listOfResults != null) {
      for (var film in listOfResults) {
        MovieListTile movie = MovieListTile(
            id: film["id"].toString(),
            imgUrl: film["image"].toString(),
            description: film["description"].toString().substring(1, 5),
            title: film["title"].toString());
        movieList.add(movie);
      }
    } else {
      print(listData["errorMessage"]);
    }
    return movieList;
  }

  Future<Movie> getMovieDetails() async {
    List castMembers = [];
    List genres = [];
    String description = "";
    NetworkHelper networkHelper =
        NetworkHelper(url: "$filmDetails$searchquery");
    var details = await networkHelper.getData();
    var castList = details["actorList"];
    String genreString = details["genres"].toString();
    String plot = details["plot"].toString();

    NetworkHelper secondnetworkHelper =
        NetworkHelper(url: "$youtubeVideoUrl$searchquery");
    var otherdetails = await secondnetworkHelper.getData();

    if (details != null && otherdetails != null) {
      for (var castMember in castList) {
        CastMember Member = CastMember(
            firstName: castMember["name"].toString().split(" ")[0],
            lastName: castMember["name"].toString().split(" ")[1],
            characterPlayed: castMember["asCharacter"],
            imageUrl: castMember["image"]);
        castMembers.add(Member);
      }
      String temp = "";
      for (int i = 0; i < genreString.length; i++) {
        if (genreString[i] == ",") {
          genres.add(temp);
          temp = "";
        } else {
          temp += genreString[i];
        }
      }
      print(castMembers);
      temp = "";
      for (int i = 0; i < plot.length; i++) {
        if (plot[i] == ".") {
          description += ".";
          break;
        } else {
          description += plot[i];
        }
      }
      Movie movieDetails = Movie(
        name: details["title"],
        imgUrl: details["image"],
        year: details["year"],
        description: description,
        castList: castMembers,
        youtubeTrailerLink: otherdetails["videoUrl"],
        imdbRating: details["imDbRating"],
        genres: genres,
        runtime: details["runtimeStr"],
      );
      print(movieDetails.toString());
      return movieDetails;
    } else {
      print(details["errorMessage"]);
      return null;
    }
  }

  static Future<List<CustomTile>> getPopulars(String url) async {
    List<CustomTile> listofcustomtile = [];
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var listData = await networkHelper.getData();
    var fetchedlist = listData["items"];
    if (fetchedlist != null) {
      for (var item in fetchedlist) {
        CustomTile temp = CustomTile(
            id: item["id"],
            imgUrl: item["image"],
            rating: item["imDbRating"],
            title: item["title"]);
        listofcustomtile.add(temp);
      }
    } else {
      print(listData["errorMessage"]);
    }

    return listofcustomtile;
  }
}
