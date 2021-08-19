import 'package:flutter/material.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/add_screen.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/screens/movie_list_screen.dart';
import 'package:provider/provider.dart';
// import 'screens/movie_list_screen.dart';
import 'package:movie_app/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MovieListProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,

        ),
        home: LoginScreen(),
        routes: {
          Add_movie.routeName: (context) => Add_movie(ModalRoute.of(context).settings.arguments as Movie),
          MovieListScreen.routeName: (context) => MovieListScreen(),
        },
      ),
    );
  }
}
