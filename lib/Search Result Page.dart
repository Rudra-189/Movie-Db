import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

class Search_Result_Page extends StatefulWidget {
  String name;
  Search_Result_Page({super.key,required this.name});

  @override
  State<Search_Result_Page> createState() => _Search_Result_PAgeState();
}

class _Search_Result_PAgeState extends State<Search_Result_Page> {

  @override
  void initState() {
    super.initState();
    getMovieDetail(widget.name);
  }

  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: data == null ? Center(child: CircularProgressIndicator(color: Colors.green.shade600,)) : SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              InkWell(
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.green.shade600.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(11)
                  ),
                  child: Icon(Icons.arrow_back,color: Colors.white,size: 18,),
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 25,),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.white.withOpacity(0.2),
                child: Row(
                  children: [
                    Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("https://image.tmdb.org/t/p/w500${data[0]['poster_path'].toString()}"),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Title : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 13),),
                              Text(data[0]['original_title'].toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 13),)
                            ],
                          ),
                          Row(
                            children: [
                              Text("Language : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 13),),
                              Text(data[0]['original_language'].toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 13),)
                            ],
                          ),
                          Row(
                            children: [
                              Text("Rating : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 13),),
                              Text(data[0]['vote_average'].toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 13),)
                            ],
                          ),
                          Row(
                            children: [
                              Text("Date : ",style: TextStyle(color: Colors.white.withOpacity(0.75),fontSize: 13),),
                              Text(data[0]['release_date'].toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 13),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> getMovieDetail(String name)async{
    print("Search result page name : "+name.toString());
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/search/movie?query=${name.toString()}&api_key=89182e82e2191b23aef42078ab24439b"));
    final jsondata = jsonDecode(response.body);
    setState(() {
      data = jsondata['results'];
    });
    print(data);
  }
}
