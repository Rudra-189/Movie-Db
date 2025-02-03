abstract class Api{

  static final String baseUrl = "https://api.themoviedb.org";
  static final int version = 3;
  static final String key = "89182e82e2191b23aef42078ab24439b";

  static final String week = "${baseUrl}/${version}/trending/all/week?api_key=${key}";

  static final String day = "${baseUrl}/${version}/trending/all/day?api_key=${key}";

  static final String popularMovie = "${baseUrl}/${version}/movie/popular?api_key=${key}";

  static final String topratedMovie = "${baseUrl}/${version}/movie/top_rated?api_key=${key}";

  static final String topratedTv = "${baseUrl}/${version}/tv/top_rated?api_key=${key}";

  static final String popularTv = "${baseUrl}/${version}/tv/popular?api_key=${key}";

  static String namesearchUrl(String name){
    return "${baseUrl}/${version}/search/movie?query=${name.toString()}&api_key=${key}";
  }

  static String idsearchUrl(int id){
    return "${baseUrl}/${version}/movie/${id}?api_key=${key}";
  }

  static String recommendationsUrl(int id){
    return "${baseUrl}/${version}/movie/${id}/recommendations?api_key=${key}&page=1";
  }
}



