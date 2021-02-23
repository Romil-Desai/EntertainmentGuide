import 'package:flutter/material.dart';

const searchBarColor = Color(0xffEBEFF2);
const searchBarContentColor = Color(0xffAAB2BD);
const searchBarDecoration = InputDecoration(
  hintText: 'Search',
  hintStyle: TextStyle(color: searchBarContentColor),
  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
  prefixIcon: Hero(
    tag: 'icon',
    child: Icon(
      Icons.search,
      size: 20.0,
      color: searchBarContentColor,
    ),
  ),
  filled: true,
  fillColor: searchBarColor,
  focusColor: searchBarColor,
  hoverColor: searchBarColor,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: searchBarColor),
      borderRadius: BorderRadius.all(Radius.circular(20.0))),
  border: OutlineInputBorder(
      borderSide: BorderSide(color: searchBarColor),
      borderRadius: BorderRadius.all(Radius.circular(20.0))),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: searchBarColor),
      borderRadius: BorderRadius.all(Radius.circular(20.0))),
);

const youtubeVideoUrl =
    "https://imdb-api.com/en/API/YouTubeTrailer/k_u3nlu8w8/";
const filmDetails = "https://imdb-api.com/en/API/Title/k_u3nlu8w8/";
const filmList = "https://imdb-api.com/en/API/SearchMovie/k_u3nlu8w8/";
const popularmovies = "https://imdb-api.com/en/API/Top250Movies/k_u3nlu8w8";
const popularseries = "https://imdb-api.com/en/API/Top250TVs/k_u3nlu8w8";
