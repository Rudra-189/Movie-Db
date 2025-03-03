import 'package:dio/dio.dart';
import 'package:movie/Exception/App_exception.dart';
import 'package:http/http.dart'as http;
import 'package:movie/models/DayDataModel.dart';
import 'package:movie/models/PopularMovieDataModel.dart';
import 'package:movie/models/RecommendationsDataModel.dart';
import 'package:movie/models/WeekDataModel.dart';
import 'package:movie/services/Api/Api_Link.dart';

abstract class ApiServices{

  static Dio dio=Dio();

  static Future<DayDataModel> getDayMovieData()async{
    final response = await dio.get(Api.day);

    switch (response.statusCode){
      case 200:
        return DayDataModel.fromJson(response.data);
      case 400:
        throw BadRequestException("This is Bad Request");
      case 500:
        throw InternalServerException("Internal Server Error");
      case 404:
        throw NotFoundException("Data Not Found");
      default :
        throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
    }

    // if(response.statusCode == 200){
    //   return DayDataModel.fromJson(jsondata);
    // }else{
    //   InternalServerException("Failed to load movie data");
    //   throw Exception('Failed to load movie data');
    // }
  }
  static Future<WeekDataModel> getWeekMovieData()async{
    final response = await dio.get(Api.week);
    switch (response.statusCode){
      case 200:
        return WeekDataModel.fromJson(response.data);
      case 400:
        throw BadRequestException("This is Bad Request");
      case 500:
        throw InternalServerException("Internal Server Error");
      case 404:
        throw NotFoundException("Data Not Found");
      default :
        throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
    }

    // if(response.statusCode == 200){
    //   return WeekDataModel.fromJson(jsondata);
    // }else{
    //   throw Exception('Failed to load movie data');
    // }
  }
  static Future<PopularMovieDataModel> getPopularMovieData()async{
    final response = await dio.get(Api.popularMovie);
    switch (response.statusCode){
      case 200:
        return PopularMovieDataModel.fromJson(response.data);
      case 400:
        throw BadRequestException("This is Bad Request");
      case 500:
        throw InternalServerException("Internal Server Error");
      case 404:
        throw NotFoundException("Data Not Found");
      default :
        throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
    }
    // if(response.statusCode == 200){
    //   return PopularMovieDataModel.fromJson(jsondata);
    // }else{
    //   throw new InternalServerException('///////Failed to load movie data//////');
    // }
  }
  static Future<RecommendationsDataModel> getdata({int id=0}) async{
    print("RecommendationsDataModel : "+id.toString());
    final response = await dio.get(Api.recommendationsUrl(id));
    switch (response.statusCode){
      case 200:
        return RecommendationsDataModel.fromJson(response.data);
      case 400:
        throw BadRequestException("This is Bad Request");
      case 500:
        throw InternalServerException("Internal Server Error");
      case 404:
        throw NotFoundException("Data Not Found");
      default :
        throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
    }

    // if(response.statusCode == 200){
    //   return RecommendationsDataModel.fromJson(jsondata);
    // }else{
    //   throw Exception('Failed to load movie data');
    // }
  }
}
//this is using http
/*static Future<DayDataModel> getDayMovieData()async{
    final response = await http.get(Uri.parse(Api.day));
    final jsondata = jsonDecode(response.body);

    switch (response.statusCode){
      case 200:
        return DayDataModel.fromJson(jsondata);
      case 400:
        throw BadRequestException("This is Bad Request");
      case 500:
        throw InternalServerException("Internal Server Error");
      case 404:
        throw NotFoundException("Data Not Found");
      default :
        throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
    }

    // if(response.statusCode == 200){
    //   return DayDataModel.fromJson(jsondata);
    // }else{
    //   InternalServerException("Failed to load movie data");
    //   throw Exception('Failed to load movie data');
    // }
  }
  static Future<WeekDataModel> getWeekMovieData()async{
    final response = await http.get(Uri.parse(Api.week));
    final jsondata = jsonDecode(response.body);
    switch (response.statusCode){
      case 200:
        return WeekDataModel.fromJson(jsondata);
      case 400:
        throw BadRequestException("This is Bad Request");
      case 500:
        throw InternalServerException("Internal Server Error");
      case 404:
        throw NotFoundException("Data Not Found");
      default :
        throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
    }

    // if(response.statusCode == 200){
    //   return WeekDataModel.fromJson(jsondata);
    // }else{
    //   throw Exception('Failed to load movie data');
    // }
  }
  static Future<PopularMovieDataModel> getPopularMovieData()async{
    final response = await http.get(Uri.parse(Api.popularMovie));
    final jsondata = jsonDecode(response.body);
    switch (response.statusCode){
      case 200:
        return PopularMovieDataModel.fromJson(jsondata);
      case 400:
        throw BadRequestException("This is Bad Request");
      case 500:
        throw InternalServerException("Internal Server Error");
      case 404:
        throw NotFoundException("Data Not Found");
      default :
        throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
    }
    // if(response.statusCode == 200){
    //   return PopularMovieDataModel.fromJson(jsondata);
    // }else{
    //   throw new InternalServerException('///////Failed to load movie data//////');
    // }
  }
  static Future<RecommendationsDataModel> getdata({int id=0}) async{
    print("RecommendationsDataModel : "+id.toString());
    final response = await http.get(Uri.parse(Api.recommendationsUrl(id)));
    final jsondata = jsonDecode(response.body);
    switch (response.statusCode){
      case 200:
        return RecommendationsDataModel.fromJson(jsondata);
      case 400:
        throw BadRequestException("This is Bad Request");
      case 500:
        throw InternalServerException("Internal Server Error");
      case 404:
        throw NotFoundException("Data Not Found");
      default :
        throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
    }

    // if(response.statusCode == 200){
    //   return RecommendationsDataModel.fromJson(jsondata);
    // }else{
    //   throw Exception('Failed to load movie data');
    // }
  }*/

