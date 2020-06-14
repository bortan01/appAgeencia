 final String _imagenMediana = "https://image.tmdb.org/t/p/w300";
 final String _imagenGrande = "https://image.tmdb.org/t/p/w500";

 List<dynamic> gereIds;

 String getMediumPictureUrl(String path){
 return _imagenMediana + path;
}

 String getGrandePictureUrl(String path){
   return _imagenGrande + path;
 }
 
List<String> getGeres() => genresToLists(gereIds);

 Map<int, String> _gereMap ={
  28:"Acción"
 ,12 :"Aventura"
 ,16:"Animación"
 ,35:"Comedia"
 ,80: "Crimen"
 ,99: "Documental"
 ,18:"Drama"
 ,10751: "Familia"
 ,14:"Fantasía"
 ,36: "Historia"
 ,27: "Terror"
 ,10402:"Música"
 ,9648: "Misterio"
 ,10749: "Romance"
 ,878: "Ciencia ficción"
 ,10770: "Película de TV"
 , 53: "Suspense"
 ,10752: "Bélica"
 ,37: "Western"
  };

 List<String> genresToLists(List<dynamic> gereIds) => gereIds.map((id) => _gereMap[id]).toList();


 String getGenrenValue(List<dynamic> gereIds){
   StringBuffer buffer = new StringBuffer();
   buffer.writeAll(genresToLists(gereIds), " ,");
   return buffer.toString();
   
 }