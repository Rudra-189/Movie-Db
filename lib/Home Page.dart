import 'dart:convert';
import 'dart:async'; // Use this for async-related functionality
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/Api/ApiServices.dart';
import 'package:movie/Api/Api_Link.dart';
import 'package:movie/App_Resources/App_Colors.dart';
import 'package:movie/Detail%20Page.dart';
import 'package:movie/Exception/App_exception.dart';
import 'package:movie/Search%20Page.dart';
import 'package:movie/utils/DayDataModel.dart';
import 'package:movie/utils/PopularMovieDataModel.dart';
import 'package:movie/utils/WeekDataModel.dart';


class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

  TextEditingController searchController = TextEditingController();
  int curentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: InkWell(
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green.shade600.withOpacity(0.5)
                ),
                child: Icon(Icons.search,color: Colors.white,size: 18,),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Search_Page()));
              },
            ),
            backgroundColor: AppColor.primaryBackgroundColor,
            pinned: false,
            expandedHeight:height*0.6,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: FutureBuilder<DayDataModel>(
                future: ApiServices.getDayMovieData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else{
                    final DayList = snapshot.data!.results!;
                    return CarouselSlider(
                        items: DayList.map((e) =>
                            InkWell(
                              child: Container(
                                height: height*0.6,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage("https://image.tmdb.org/t/p/w500${e.posterPath}"),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Detail_Page(id: e.id!),));
                              },
                            ),).toList(),
                        options: CarouselOptions(
                          height: height * 0.6,
                          initialPage: 0,
                          aspectRatio: 16 / 9,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(
                              milliseconds: 800),
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlay: true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              curentIndex = index;
                            });
                          },
                        )
                    );
                  }
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Today Movie",style: TextStyle(color: AppColor.subFontColor),),
                        Text("View More",style: TextStyle(color: AppColor.subFontColor)),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: height *0.425,
                      child: FutureBuilder<WeekDataModel>(
                        future: ApiServices.getWeekMovieData(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }else{
                            final WeekList = snapshot.data!.results;
                            return ListView.builder(itemBuilder: (context, index) {
                              return InkWell(
                                child:Container(
                                  height: 0.425,
                                  width: width * 0.45,
                                  color: Colors.white.withOpacity(0.2),
                                  margin: EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: height * 0.315,
                                        width: width * 0.45,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage("https://image.tmdb.org/t/p/w500${WeekList[index].posterPath}"),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                      Expanded(
                                        child:Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Title : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 12),),
                                                  Text(WeekList[index].originalTitle.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 12),)
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("Language : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 12),),
                                                  Text(WeekList[index].originalLanguage.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 12),)
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("Rating : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 12),),
                                                  Text(WeekList[index].voteAverage.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 12),)
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("Date : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 12),),
                                                  Text(WeekList[index].releaseDate.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 12),)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Detail_Page(id: WeekList[index].id!,),));
                                },
                              );
                            },
                              itemCount: WeekList!.length,
                              scrollDirection: Axis.horizontal,
                            );
                          }
                        },
                      )
                    ),
                    SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Popular Movie",style: TextStyle(color: AppColor.subFontColor),),
                        Text("View More",style: TextStyle(color: AppColor.primaryFontColor)),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 2300,
                      child: FutureBuilder<PopularMovieDataModel>(
                        future: ApiServices.getPopularMovieData(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }else{
                            final PopularList = snapshot.data!.results;
                            return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 25,
                                mainAxisSpacing: 25,
                                mainAxisExtent: height * 0.45,
                              ) ,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: Container(
                                    color: Colors.white.withOpacity(0.2),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: height * 0.315,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage("https://image.tmdb.org/t/p/w500${PopularList[index].posterPath}"),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child:Row(
                                                    children: [
                                                      Text("Title : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 13),),
                                                      Expanded(
                                                        child: Text(PopularList[index].originalTitle.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Language : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 13),),
                                                    Text(PopularList[index].originalLanguage.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Rating : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 13),),
                                                    Text(PopularList[index].voteAverage.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Date : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 13),),
                                                    Text(PopularList[index].releaseDate.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),)
                                                  ],
                                                )
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Detail_Page(id: PopularList[index].id!),));
                                  },
                                );
                              },
                              itemCount: PopularList!.length,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  // Future<DayDataModel> getDayMovieData()async{
  //   final response = await http.get(Uri.parse(Api.day));
  //   final jsondata = jsonDecode(response.body);
  //
  //   switch (response.statusCode){
  //     case 200:
  //       return DayDataModel.fromJson(jsondata);
  //     case 400:
  //       throw BadRequestException("This is Bad Request");
  //     case 500:
  //       throw InternalServerException("Internal Server Error");
  //     case 404:
  //       throw NotFoundException("Data Not Found");
  //     default :
  //       throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
  //   }
  //
  //   // if(response.statusCode == 200){
  //   //   return DayDataModel.fromJson(jsondata);
  //   // }else{
  //   //   InternalServerException("Failed to load movie data");
  //   //   throw Exception('Failed to load movie data');
  //   // }
  // }
  //
  // Future<WeekDataModel> getWeekMovieData()async{
  //   final response = await http.get(Uri.parse(Api.week));
  //   final jsondata = jsonDecode(response.body);
  //   switch (response.statusCode){
  //     case 200:
  //       return WeekDataModel.fromJson(jsondata);
  //     case 400:
  //       throw BadRequestException("This is Bad Request");
  //     case 500:
  //       throw InternalServerException("Internal Server Error");
  //     case 404:
  //       throw NotFoundException("Data Not Found");
  //     default :
  //       throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
  //   }
  //
  //   // if(response.statusCode == 200){
  //   //   return WeekDataModel.fromJson(jsondata);
  //   // }else{
  //   //   throw Exception('Failed to load movie data');
  //   // }
  // }
  //
  // Future<PopularMovieDataModel> getPopularMovieData()async{
  //   final response = await http.get(Uri.parse(Api.popularMovie));
  //   final jsondata = jsonDecode(response.body);
  //   switch (response.statusCode){
  //     case 200:
  //       return PopularMovieDataModel.fromJson(jsondata);
  //     case 400:
  //       throw BadRequestException("This is Bad Request");
  //     case 500:
  //       throw InternalServerException("Internal Server Error");
  //     case 404:
  //       throw NotFoundException("Data Not Found");
  //     default :
  //       throw FetchDataException("Error occur While communication with server"+'with status code : '+response.statusCode.toString());
  //   }
  //   // if(response.statusCode == 200){
  //   //   return PopularMovieDataModel.fromJson(jsondata);
  //   // }else{
  //   //   throw new InternalServerException('///////Failed to load movie data//////');
  //   // }
  // }
}
