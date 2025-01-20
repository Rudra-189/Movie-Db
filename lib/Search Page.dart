import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/Api_Link.dart';
import 'package:movie/Detail%20Page.dart';
import 'package:movie/Search%20Result%20Page.dart';
import 'package:movie/utils/SearchDataModel.dart';

class Search_Page extends StatefulWidget {
  const Search_Page({super.key});

  @override
  State<Search_Page> createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {

  TextEditingController SearchController = TextEditingController();
  List SearchData = [];

  var Search=day;

  @override
  Widget build(BuildContext context) {
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
                  controller: SearchController,
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
                          if(SearchController.text.toString().isNotEmpty){
                            setState(() {
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Search_Result_Page(name: SearchController.text.toLowerCase()),)).then((value) {
                              print(SearchController.text.toLowerCase().toString());
                              if(!SearchData.contains(SearchController.text.toLowerCase().toString())){
                                SearchData.add(SearchController.text.toLowerCase().toString());
                              }
                              SearchController.clear();
                            },);
                          }
                        },
                        icon: Icon(Icons.arrow_forward,color: Colors.green.shade600,),
                      )
                  ),
                ),
                SizedBox(height: 10,),
                SearchData.isNotEmpty ? Container(
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
                              child: Text(SearchData[index].toString(),style: TextStyle(color: Colors.white),),
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.green),
                                    top: BorderSide(color: Colors.green),
                                    left: BorderSide(color: Colors.green),
                                    right: BorderSide(color: Colors.green),
                                  ),
                                  borderRadius: BorderRadius.circular(11)
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                SearchController.text = SearchData[index];
                              });
                            },
                          );
                        },
                          itemCount: SearchData.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      IconButton(
                          onPressed: (){
                            setState(() {
                              SearchData.clear();
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
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(11)
                        ),
                        child: Center(child: Text("Popular Ty Shows",style: TextStyle(color: Colors.white),)),
                      ),
                      onTap: (){
                        setState(() {
                          Search = popularTv;
                        });

                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(11)
                        ),
                        child: Center(child: Text("Popular Movies",style: TextStyle(color: Colors.white),)),
                      ),
                      onTap: (){
                        setState(() {
                          Search = popularMovie;
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
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(11)
                        ),
                        child: Center(child: Text("Day Trending",style: TextStyle(color: Colors.white),)),
                      ),
                      onTap: (){
                        setState(() {
                          Search =day;
                        });

                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(11)
                        ),
                        child: Center(child: Text("Week Trending",style: TextStyle(color: Colors.white),)),
                      ),
                      onTap: (){
                        setState(() {
                          Search =week;
                        });

                      },
                    ),
                    InkWell(
                      child:Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(11)
                        ),
                        child: Center(child: Text("Top Rated Tv Shows",style: TextStyle(color: Colors.white),)),
                      ),
                      onTap: (){
                        setState(() {
                          Search =topratedTv;
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
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(11)
                        ),
                        child: Center(child: Text("Top Rated Movie",style: TextStyle(color: Colors.white),)),
                      ),
                      onTap: (){
                        setState(() {
                          Search =topratedMovie;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 25,),
                Container(
                  height: 2240,
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
                            mainAxisExtent: 350,
                          ) ,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                color: Colors.white.withOpacity(0.2),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 250,
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
                                                  Text("Title : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 13),),
                                                  Text(result[index].originalTitle.toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 13),)
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text("Language : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 13),),
                                                Text(result[index].originalLanguage.toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 13),)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Rating : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 13),),
                                                Text(result[index].voteAverage.toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 13),)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Date : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 13),),
                                                Text(result[index].releaseDate.toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 13),)
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
    if(response.statusCode == 200){
      return SearchDataModel.fromJson(jsondata);
    }else{
      throw Exception('Failed to load movie data');
    }
  }

}
