import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_app/helpers/db_helper.dart';
import 'package:movie_app/model/movie.dart';

class MovieListProvider with ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movieList {
    return [..._movies];
  }

// function to add movie into the database
  void addMovie(String providedId, String title, String imageUrl, String director) {
    final movieId = providedId == null ? DateTime.now().toString() : providedId;
    final newMovie = Movie(
      id: movieId,
      title: title,
      imageUrl: imageUrl,
      director: director,
    );
    if (providedId != null) {
      _movies.removeWhere((element) => element.id == providedId);
    }
    _movies.add(newMovie);
    notifyListeners();
    DBHelper.insert('list_movies', {
      'id': newMovie.id,
      'title': newMovie.title,
      'image': newMovie.imageUrl,
      'director': newMovie.director
    });
  }

// function to fetch data from the database
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('list_movies');
    _movies = dataList
        .map((item) => Movie(
      id: item['id'],
      title: item['title'],
      imageUrl: item['image'],
      director: item['director'],
    ))
        .toList();
    notifyListeners();
  }

  // function to delete the movie from database
  Future<void> deleteMovie(String title_deleted) async {
    _movies.removeWhere((element) => element.title == title_deleted);
    notifyListeners();
    DBHelper.delete('list_movies', title_deleted);
  }
}
