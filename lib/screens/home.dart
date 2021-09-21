import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/screens/article_view.dart';
import 'package:news_app/screens/category_news.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories= new List<CategorieModel>();
  List<ArticleModel> articles  =  new List<ArticleModel>();
  bool _loading = true;
  void getNews() async {
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  void initState(){
    super.initState();
    categories = getCategories();
    getNews();

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
      body: _loading ? Center(child: Container(child: CircularProgressIndicator())) :SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              /// Categories
              Container(
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index){
                    return CategoryTile(
                      imageUrl: categories[index].imageAssetUrl,
                      categoryName: categories[index].categorieName,
                    );
                  },
                ),
              ),
              ///Blogs
              Container(
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

            ],
          ),
        ),
      ),
    );
  }
}


class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;
  CategoryTile({this.imageUrl,this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Category(
          category: categoryName,
        )));

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl, height: 60,width: 120,fit: BoxFit.cover,),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,

              ),
              child: Text(
                  categoryName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,


              )),
            )

          ],
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
