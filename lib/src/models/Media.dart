import 'package:peliculas/src/common/util.dart';

class Media {
  int id ;
  double voteAverage;
  String title;
  String posterPath;
  String backdropPath;
  String overView;
  String releaseDate;
  List<dynamic> genreIds;

  String getPosterUrl() => getMediumPictureUrl(posterPath);
  String getBackDropUrl() => getGrandePictureUrl(backdropPath);
  String getGenres () => getGenrenValue(gereIds);

  factory Media(Map jsonMap){
    return new Media.deserialize(jsonMap);
  }

  Media.deserialize(Map json) :
        id = json['id'].toInt(),
       voteAverage  = json['vote_average'].toDouble(),
        title  = json['title'],
        posterPath  = json['poster_path'] ?? "",
        backdropPath  = json['backdrop_path'] ?? "",
        overView  = json['overview'],
        releaseDate  = json['release_date'],
        genreIds  = json['genre_ids'].toList();
 }

