class Movie {
  String imgUrl;
  String year;
  String description;
  String youtubeTrailerLink;
  List<dynamic> castList;
  String imdbRating;
  List<dynamic> genres;
  String runtime;
  String name;

  Movie(
      {this.imgUrl,
      this.year,
      this.description,
      this.youtubeTrailerLink,
      this.castList,
      this.imdbRating,
      this.genres,
      this.runtime,
      this.name});

  @override
  String toString() {
    return 'Movie{imgUrl: $imgUrl, year: $year, description: $description, youtubeTrailerLink: $youtubeTrailerLink, castList: $castList, imdbRating: $imdbRating, genres: $genres, runtime: $runtime}';
  }
}

class MovieListTile {
  String id;
  String imgUrl;
  String description;
  String title;

  MovieListTile({this.id, this.imgUrl, this.description, this.title});
}

class CastMember {
  String firstName;
  String lastName;
  String characterPlayed;
  String imageUrl;

  CastMember(
      {this.firstName, this.lastName, this.characterPlayed, this.imageUrl});
}

class CustomTile {
  String id;
  String imgUrl;
  String title;
  String rating;

  @override
  String toString() {
    return 'CustomTile{id: $id, imgUrl: $imgUrl, title: $title, rating: $rating}';
  }

  CustomTile({this.id, this.imgUrl, this.title, this.rating});
}
