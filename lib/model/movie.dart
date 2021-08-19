import 'dart:io';
import 'package:flutter/material.dart';

class Movie with ChangeNotifier {
  final String id;
  String title;
  String imageUrl;
  String director;

  Movie(
      {this.id,
        @required this.title,
        @required this.imageUrl,
        @required this.director});
}

List<Movie> movieList = [];
