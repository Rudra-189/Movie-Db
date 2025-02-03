import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie/App_Resources/App_Colors.dart';
import 'package:movie/App_Resources/App_Icons.dart';
import 'package:movie/models/DayDataModel.dart';
import 'package:movie/models/PopularMovieDataModel.dart';
import 'package:movie/models/WeekDataModel.dart';
import 'package:movie/routes/app_routes_name.dart';
import 'package:movie/services/Api/ApiServices.dart';


class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

  GoogleSignIn googleSignIn = GoogleSignIn();

  TextEditingController searchController = TextEditingController();
  int curentIndex = 0;

  late Future<DayDataModel> _dayMovie;
  late Future<WeekDataModel> _weekMovie;
  late Future<PopularMovieDataModel> _populerMovie;

  @override
  void initState() {
    super.initState();
    _dayMovie = ApiServices.getDayMovieData();
    _weekMovie = ApiServices.getWeekMovieData();
    _populerMovie = ApiServices.getPopularMovieData();
  }


  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(onPressed: (){
            }, icon: AppIcon.menuIcon),
            actions: [
              InkWell(
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade600.withOpacity(0.5)
                  ),
                  child: Icon(Icons.search,color: Colors.white,size: 18,),
                ),
                onTap: (){
                  Navigator.pushNamed(context,AppRoutesName.searchPage);
                },
              ),
              SizedBox(width: 10,),
            ],
            backgroundColor: AppColor.primaryBackgroundColor,
            pinned: true,
            expandedHeight:height*0.6,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: FutureBuilder<DayDataModel>(
                future: _dayMovie,
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
                                Navigator.pushNamed(context,AppRoutesName.detailPage,arguments: e.id);
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
                        future: _weekMovie,
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
                                  Navigator.pushNamed(context,AppRoutesName.detailPage,arguments:WeekList[index].id!,);
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
                        future: _populerMovie,
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
                                    Navigator.pushNamed(context,AppRoutesName.detailPage,arguments: PopularList[index].id!);
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
}
