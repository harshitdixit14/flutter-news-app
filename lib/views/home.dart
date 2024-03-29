import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/views/article_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _State createState()=>_State();
}
class _State extends State<Home> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  void initState(){
    super.initState();
    categories=getCategories();
    getNews();
  }
  getNews() async{
    News newsClass=News();
    await newsClass.getNews();
    articles=newsClass.news;
    setState((){
      _loading=false;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter',style:TextStyle(color:Colors.white,)),
            Text('News',style:TextStyle(color:Colors.blue,)),
          ]
          ),
          elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child:CircularProgressIndicator(),
        ),
      ):
      SingleChildScrollView(
        child: Container(
            child: Column(
              children: <Widget>[
                // categories
                Container(
                  padding:EdgeInsets.symmetric(horizontal: 16),
                  height:70,
                  child:ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                    }),
                ),
                // blog
               Container(
                    padding:EdgeInsets.only(top:16),
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: articles.length,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        return BlogTile(
                          imageUrl: articles[index].urlToImage,
                          title:articles[index].title,
                          desc:articles[index].description,
                          url:articles[index].url,
                        );
                      }),
                  ),
              ],
            ),
          ),
      ),
    );
  }
}
class CategoryTile extends StatelessWidget{
  final imageUrl,categoryName;
  CategoryTile({this.imageUrl,this.categoryName});
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      child: Container(
        margin:EdgeInsets.only(right:16),
        child:Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(imageUrl:imageUrl,width: 120,height:60,fit:BoxFit.cover,)
              ),
            Container(
              alignment: Alignment.center,
              width:120,
              height:60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color:Colors.black26,
              ),
              child:Text(categoryName,style:TextStyle(color:Colors.white,fontSize: 14,fontWeight:FontWeight.w500,)),
            ),
          ],
        ),
      ),
    );
  }
}
class BlogTile extends StatelessWidget{
  final imageUrl,title,desc,url;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});
  @override
  Widget build(BuildContext context)
  {
    return  GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(
          builder: (context)=>ArticleView(
            blogUrl: url,
          )
          ));
      },
      child: Container(
        margin:EdgeInsets.only(bottom:16),
      
          child:Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl,width: 400,),
                ),
              SizedBox(height: 8,),
              Text(title,style:TextStyle(
                fontSize: 17,
                color:Colors.black54,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(height: 8,),
              Text(desc,style:TextStyle(
                color:Colors.grey,
              )),
            ],
          )
      ),
    );
  }
}