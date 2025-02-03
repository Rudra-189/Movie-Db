import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/App_Resources/App_Colors.dart';
import 'package:movie/Exception/App_exception.dart';
import 'package:movie/models/MovieDetail.dart';
import 'package:movie/models/RecommendationsDataModel.dart';
import 'package:movie/routes/app_routes_name.dart';
import 'package:movie/services/Api/Api_Link.dart';
import 'package:readmore/readmore.dart';

class Detail_Page extends StatefulWidget {
  int id;
  Detail_Page({super.key,required this.id});

  @override
  State<Detail_Page> createState() => _Detail_PageState();
}

class _Detail_PageState extends State<Detail_Page> {

  Dio dio=Dio();
  
  late Future<MovieDetail> _movieDetail;

  @override
  void initState() {
    super.initState();
    getMovieDetail(widget.id);
  }

  var data;
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: data == null ? Center(child: CircularProgressIndicator(color: Colors.green.shade600,),) :CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.primaryBackgroundColor,
            pinned: false,
            expandedHeight:height* 0.6,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: height* 0.6,
                width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("https://image.tmdb.org/t/p/w500${data['poster_path']}"),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child:Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Name : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 13),),
                      Text(data['original_title'],style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Release Date : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 13),),
                      Text(data['release_date'].toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Languages : ",style: TextStyle(color:AppColor.movieDetailFrontColor,fontSize: 13),),
                      Text(data['original_language'],style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Rating : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 13),),
                      Text(data['vote_average'].toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),),
                    ],
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Over View of Movie",style: TextStyle(color: AppColor.movieDetailFrontColor),)
                    ],),
                  SizedBox(height: 10,),
                  ReadMoreText(
                    data['overview'],
                    style: TextStyle(color: AppColor.movieDetailFrontColor),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    color: Colors.white.withOpacity(0.25),
                  ),
                  SizedBox(height: 10,),
                  Text("Similar Movies",style: TextStyle(color: AppColor.subFontColor),),
                  SizedBox(height: 10,),
                  Container(
                    height: height * 0.35,
                    child: FutureBuilder<RecommendationsDataModel>(
                      future: getdata(widget.id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }else{
                          final Data = snapshot.data!.results;
                          return ListView.builder(itemBuilder: (context, index) {
                            return InkWell(
                              child:Container(
                                height: height * 0.35,
                                width: width * 0.45,
                                color: Colors.white.withOpacity(0.2),
                                margin: EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: height * 0.275,
                                      width: width * 0.45,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage("https://image.tmdb.org/t/p/w500${Data[index].posterPath}"),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                    Expanded(
                                      child:Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Title : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 12),),
                                              Text(Data[index].originalTitle.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 12),)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Language : ",style: TextStyle(color:AppColor.movieDetailFrontColor,fontSize: 12),),
                                              Text(Data[index].originalLanguage.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 12),)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Rating : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 12),),
                                              Text(Data[index].voteAverage.toString(),style: TextStyle(color:AppColor.primaryFontColor,fontSize: 12),)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Date : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 12),),
                                              Text(Data[index].releaseDate.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 12),)
                                            ],
                                          )
                                        ],
                                      )
                                    )
                                  ],
                                ),
                              ),
                              onTap: (){
                                Navigator.pushNamed(context,AppRoutesName.detailPage,arguments: Data[index].id!);
                              },
                            );
                          },
                            itemCount: Data!.length,
                            scrollDirection: Axis.horizontal,
                          );
                        }
                      },
                    )
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Future<void> getMovieDetail(int id)async{
    final response = await dio.get(Api.idsearchUrl(id));
    switch (response.statusCode){
      case 200:
        setState(() {
          data=response.data;
        });
      case 400:
        throw BadRequestException("This is Bad Request");
      case 500:
        throw InternalServerException("Internal Server Error");
      case 404:
        throw NotFoundException("Data Not Found");
      default :
        throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
    }
  }
  Future<RecommendationsDataModel> getdata(int id) async{
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
