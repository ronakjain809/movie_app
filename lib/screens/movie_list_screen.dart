import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/add_screen.dart';
import 'package:provider/provider.dart';
import 'movie_detail_screen.dart';
import 'package:movie_app/model/movie.dart';

class MovieListScreen extends StatelessWidget {
  static const  routeName = '/movie_list';
  final _hasMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('WATCHED MOVIES',style: GoogleFonts.openSans(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold,),), actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Add_movie.routeName);
          },
          icon: Icon(Icons.add),
        )
      ]),
      body: FutureBuilder(
        future: Provider.of<MovieListProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<MovieListProvider>(
                child: Center(
                  child: const Text("Got no movies !!"),
                ),
                builder: (ctx, movielistprovider, ch) => movielistprovider
                            .movieList.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: movielistprovider.movieList.length,
                        itemBuilder: (context, index) => Card(
                          elevation: 10,
                          child: ListTile(
                            title:
                                Text(movielistprovider.movieList[index].title,
                                style: GoogleFonts.openSans(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                            subtitle: Text(movielistprovider
                                .movieList[index].director
                                .toString(),
                            style: GoogleFonts.openSans(color: Colors.black, fontSize: 15),),
                            leading: Image.network(
                                movielistprovider.movieList[index].imageUrl),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                Provider.of<MovieListProvider>(context,
                                        listen: false)
                                    .deleteMovie(movielistprovider
                                        .movieList[index].title);
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailsScreen(
                                      movielistprovider.movieList[index]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}

// ListView.builder(
//             itemCount: movieList.length,
//             itemBuilder: (context, index) {
//               Movie movie = movieList[index];
//               return Card(
//                 child: ListTile(
//                   title: Text(movie.title),
//                   subtitle: Text(movie.year.toString()),
//                   leading: Image.network(movie.imageUrl),
//                   trailing: Icon(Icons.arrow_forward_rounded),
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => MovieDetailsScreen(movie)));
//                   },
//                 ),
//               );
//             })
