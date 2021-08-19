import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/model/movie.dart';

import 'add_screen.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const routeName = '/movie_detail';
  final Movie movie;

  MovieDetailsScreen(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(movie.title.toUpperCase(), style: GoogleFonts.openSans(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
        actions: [IconButton(onPressed: (){
          Navigator.of(context).pushNamed(Add_movie.routeName, arguments: movie);
        }, icon: Icon(Icons.edit))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(39.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                movie.imageUrl,
                height: 480,
                width: 400,

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Row(children: [
                  Text(
                    "Movie name: ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " "+movie.title.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(color: Colors.black, fontSize: 17),
                  ),
                ],)
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Text(
                    "Director: ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " "+movie.director,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(color: Colors.black, fontSize: 17),
                  ),
                ],)

              ),
            ],
          ),
        ),
      ),
    );
  }
}
