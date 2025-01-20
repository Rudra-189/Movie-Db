import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/utils/RecommendationsDataModel.dart';
import 'package:readmore/readmore.dart';

class Detail_Page extends StatefulWidget {
  int id;
  Detail_Page({super.key,required this.id});

  @override
  State<Detail_Page> createState() => _Detail_PageState();
}

class _Detail_PageState extends State<Detail_Page> {

  @override
  void initState() {
    super.initState();
    getMovieDetail(widget.id);
  }
  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: data == null ? Center(child: CircularProgressIndicator(color: Colors.green.shade600,),) :CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            pinned: false,
            expandedHeight:550,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: 550,
                width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("https://image.tmdb.org/t/p/w500${data['poster_path']}",),
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
                      Text("Name : ",style: TextStyle(color: Colors.white,fontSize: 13),),
                      Text(data['original_title'],style: TextStyle(color: Colors.green.shade600,fontSize: 13),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Release Date : ",style: TextStyle(color: Colors.white,fontSize: 13),),
                      Text(data['release_date'].toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 13),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Languages : ",style: TextStyle(color: Colors.white,fontSize: 13),),
                      Text(data['original_language'],style: TextStyle(color: Colors.green.shade600,fontSize: 13),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Rating : ",style: TextStyle(color: Colors.white,fontSize: 13),),
                      Text(data['vote_average'].toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 13),),
                    ],
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Over View of Movie",style: TextStyle(color: Colors.white),)
                    ],),
                  SizedBox(height: 10,),
                  ReadMoreText(
                    data['overview'],
                    style: TextStyle(color: Colors.white.withOpacity(0.75)),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    color: Colors.white.withOpacity(0.25),
                  ),
                  SizedBox(height: 10,),
                  Text("Similar Movies",style: TextStyle(color: Colors.white),),
                  SizedBox(height: 10,),
                  Container(
                    height: 250,
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
                                height: 325,
                                width: 175,
                                color: Colors.white.withOpacity(0.2),
                                margin: EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 250,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage("https://image.tmdb.org/t/p/w500${Data[index].posterPath}"),
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
                                                Text("Title : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 12),),
                                                Text(Data[index].originalTitle.toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 12),)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Language : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 12),),
                                                Text(Data[index].originalLanguage.toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 12),)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Rating : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 12),),
                                                Text(Data[index].voteAverage.toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 12),)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Date : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 12),),
                                                Text(Data[index].releaseDate.toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 12),)
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Detail_Page(id: Data[index].id!,),));
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
                  SizedBox(height: 100,)
                ],
              ),
            ),
          )
        ],
      )
    );
  }
  Future<void> getMovieDetail(int id)async{
    print(id);
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/${id}?api_key=89182e82e2191b23aef42078ab24439b"));
    final jsondata = jsonDecode(response.body);
    setState(() {
      data = jsondata;
    });
    print(data);
  }

  Future<RecommendationsDataModel> getdata(int id) async{
    print("RecommendationsDataModel : "+id.toString());
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/${id}/recommendations?api_key=89182e82e2191b23aef42078ab24439b&page=1"));
    final jsondata = jsonDecode(response.body);

    if(response.statusCode == 200){
      return RecommendationsDataModel.fromJson(jsondata);
    }else{
      throw Exception('Failed to load movie data');
    }
  }

}
