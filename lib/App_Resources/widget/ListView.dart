import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/App_Resources/App_Colors.dart';
import 'package:movie/Detail%20Page.dart';

class custom_ListView extends StatelessWidget {
  List WeekList; // List of movie objects
  double width;
  double height;
  custom_ListView({
    super.key,
    required this.WeekList,
    required this.width,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
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
                        image: NetworkImage("https://image.tmdb.org/t/p/w500${WeekList[0]['poster_path']}"),
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
}
