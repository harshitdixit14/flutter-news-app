import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/models/category_model.dart';

class Home extends StatefulWidget {
  @override
  _State createState()=>_State();
}
class _State extends State<Home> {
  List<CategoryModel> categories = List.empty();
  void initState(){
    super.initState();
    categories=getCategories();
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
      body: Container(
        child: Column(
          children: [
            Container(
              child:ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return CategoryTile(
                    imageUrl: categories[index].imageUrl,
                    categoryName: categories[index].categoryName,
                  );
                }),
            ),
          ],
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
    return Container(
      child:Stack(
        children: <Widget>[
          Image.network(imageUrl,width: 120,height:60,),
        ],
      ),
    );
  }
}