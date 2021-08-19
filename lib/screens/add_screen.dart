import 'package:flutter/material.dart';
import 'package:movie_app/helpers/db_helper.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/movie_list_screen.dart';
import 'package:provider/provider.dart';

class Add_movie extends StatefulWidget {
  static const routeName = '/add_movie';

  final Movie movie;

  Add_movie(this.movie);

  @override
  _Add_movieState createState() => _Add_movieState(movie);
}

class _Add_movieState extends State<Add_movie> {
  final titleTextController = TextEditingController();
  final directorTextController = TextEditingController();
  final imageTextController = TextEditingController();
  var focusNode = FocusNode();


  final Movie movie;

  _Add_movieState(this.movie) {
    if (movie != null) {
      titleTextController.text = movie.title;
      directorTextController.text = movie.director;
      imageTextController.text = movie.imageUrl;
    }
    imageTextController.addListener(() {
        if (focusNode.hasFocus) return;
        setState(() {
        });
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleTextController.dispose();
    directorTextController.dispose();
    imageTextController.dispose();
  }

  // function to save the movie data
  void _saveMovie() {
    if (titleTextController.text.isEmpty ||
        directorTextController.text.isEmpty ||
        imageTextController.text.isEmpty) {
      return;
    }
    Provider.of<MovieListProvider>(context, listen: false).addMovie(
      movie?.id,
      titleTextController.text,
      imageTextController.text,
      directorTextController.text,
    );
    Navigator.of(context).pop();
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pushNamed(MovieListScreen.routeName);
    }
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Movie Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Movie name"),
                maxLines: 1,
                controller: titleTextController,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                focusNode: focusNode,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Image URL"),
                maxLines: 1,
                controller: imageTextController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Director's name"),
                maxLines: 1,
                controller: directorTextController,
              ),
            ),

            Container(
              width: 250,
              height: 300,
              margin: EdgeInsets.only(
                top: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: imageTextController.text.isEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Enter a URL'),
                    Icon(Icons.image_rounded),
                  ],
                )
                    : FittedBox(
                  child: Image.network(imageTextController.text,
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: _saveMovie,
      ),
    );
  }
}
