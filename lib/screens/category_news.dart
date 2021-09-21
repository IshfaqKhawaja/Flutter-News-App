import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/screens/article_view.dart';
 class Category extends StatefulWidget {
   final String category;
   Category({this.category});
   @override
   _CategoryState createState() => _CategoryState();
 }
 
 class _CategoryState extends State<Category> {
   List<ArticleModel> articles = new List<ArticleModel>();
   bool _loading = true;
   void getCategoryNews() async {
     CategoryNews categoryNews = CategoryNews();
     await categoryNews.getCategory(widget.category);
     articles = categoryNews.news;
     setState(() {
       _loading = false;
     });
   }
  @override
   void initState(){
     super.initState();
     getCategoryNews();

   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
         appBar: AppBar(
         title: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children:[
         Text('News'),
     Text(
     'App',
     style: TextStyle(
     color: Colors.blue,
     ),
     ),
     ]
     ),
     centerTitle: true,
     elevation: 0.0,
     ),
       body: _loading?Center(child: CircularProgressIndicator()) : SingleChildScrollView(
           child: Container(
             child:  Container(
                 margin: EdgeInsets.only(bottom: 16),
                 child: Container(
                   padding: EdgeInsets.symmetric(horizontal: 16),
                     child: ListView.builder(
                       physics: ClampingScrollPhysics(),
                       shrinkWrap: true,
                       itemCount: articles.length,
                       itemBuilder: (context,index){
                         return BlogTile(
                           imageUrl: articles[index].urlToImage,
                           title: articles[index].title,
                           desc: articles[index].description,
                           url: articles[index].url,
                         );
                       },
                     )
                 )


             ),

           ),
         ),

     );
   }
 }


class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc,url;

  BlogTile({this.imageUrl, this.title, this.desc,this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> Article(blogUrl: url)));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(imageUrl)),
              SizedBox(height: 8),
              Text(title,style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                letterSpacing: 1.2,

              )),
              SizedBox(height: 8),
              Text(desc,style: TextStyle(
                color: Colors.grey,
              )),
            ],
          )
      ),
    );
  }
}

