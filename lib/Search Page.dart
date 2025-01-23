import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/Api/Api_Link.dart';
import 'package:movie/App_Resources/App_Colors.dart';
import 'package:movie/App_Resources/widget/Button_Ui_2.dart';
import 'package:movie/Detail%20Page.dart';
import 'package:movie/Exception/App_exception.dart';
import 'package:movie/Search%20Result%20Page.dart';
import 'package:movie/utils/SearchDataModel.dart';

class Search_Page extends StatefulWidget {
  const Search_Page({super.key});

  @override
  State<Search_Page> createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {

  TextEditingController searchController = TextEditingController();
  List searchData = [];

  var Search=Api.day;

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  controller: searchController,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.green.shade600,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.25),
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.green.shade600,
                          )
                      ),
                      prefixIcon: Icon(Icons.search,color: Colors.green.shade600,),
                      suffixIcon: IconButton(
                        onPressed: (){
                          if(searchController.text.toString().isNotEmpty){
                            setState(() {
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Search_Result_Page(name: searchController.text.toLowerCase()),)).then((value) {
                              print(searchController.text.toLowerCase().toString());
                              if(!searchData.contains(searchController.text.toLowerCase().toString())){
                                searchData.add(searchController.text.toLowerCase().toString());
                              }
                              searchController.clear();
                            },);
                          }
                        },
                        icon: Icon(Icons.arrow_forward,color: Colors.green.shade600,),
                      )
                  ),
                ),
                SizedBox(height: 10,),
                searchData.isNotEmpty ? Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width *0.8,
                        height: 30,
                        child: ListView.builder(itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                              height: 30,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(left: 5),
                              child: Text(searchData[index].toString(),style: TextStyle(color: Colors.white),),
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: AppColor.primaryColor),
                                    top: BorderSide(color: AppColor.primaryColor),
                                    left: BorderSide(color: AppColor.primaryColor),
                                    right: BorderSide(color: AppColor.primaryColor),
                                  ),
                                  borderRadius: BorderRadius.circular(11)
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                searchController.text = searchData[index];
                              });
                            },
                          );
                        },
                          itemCount: searchData.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      IconButton(
                          onPressed: (){
                            setState(() {
                              searchData.clear();
                            });
                          },
                          icon:Icon(Icons.clear,color: Colors.green.shade600,)
                      )
                    ],
                  ),
                ) : Container(),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: custom_Button_2(name: "Popular Ty Shows"),
                      onTap: (){
                        setState(() {
                          Search = Api.popularTv;
                        });

                      },
                    ),
                    InkWell(
                      child: custom_Button_2(name: "Popular Movies"),
                      onTap: (){
                        setState(() {
                          Search = Api.popularMovie;
                        });

                      },
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: custom_Button_2(name: "Day Trending"),
                      onTap: (){
                        setState(() {
                          Search =Api.day;
                        });

                      },
                    ),
                    InkWell(
                      child: custom_Button_2(name: "Week Trending"),
                      onTap: (){
                        setState(() {
                          Search =Api.week;
                        });

                      },
                    ),
                    InkWell(
                      child:custom_Button_2(name: "Top Rated Tv Shows"),
                      onTap: (){
                        setState(() {
                          Search =Api.topratedTv;
                        });

                      },
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child:custom_Button_2(name: "Top Rated Movie"),
                      onTap: (){
                        setState(() {
                          Search =Api.topratedMovie;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 25,),
                Container(
                  height: 2300,
                  child: FutureBuilder<SearchDataModel>(
                    future: getData(Search),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }else{
                        final result = snapshot.data!.results;
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
                                      height:height * 0.315,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage("https://image.tmdb.org/t/p/w500${result[index].posterPath}"),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width:350,
                                              child:Row(
                                                children: [
                                                  Text("Title : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 13),),
                                                  Text(result[index].originalTitle.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),)
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text("Language : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 13),),
                                                Text(result[index].originalLanguage.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Rating : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 13),),
                                                Text(result[index].voteAverage.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Date : ",style: TextStyle(color: AppColor.movieDetailFrontColor,fontSize: 13),),
                                                Text(result[index].releaseDate.toString(),style: TextStyle(color: AppColor.primaryFontColor,fontSize: 13),)
                                              ],
                                            )
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Detail_Page(id: result[index].id!),));
                              },
                            );
                          },
                          itemCount: result!.length,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
  Future<SearchDataModel> getData(String data)async{
    print("getdata is call on : "+data);
    final response = await http.get(Uri.parse(data));
    final jsondata = jsonDecode(response.body);
    switch (response.statusCode){
      case 200:
        return SearchDataModel.fromJson(jsondata);
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
    //   return SearchDataModel.fromJson(jsondata);
    // }else{
    //   throw Exception('Failed to load movie data');
    // }
  }

}

