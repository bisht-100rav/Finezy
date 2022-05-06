import 'articleview.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'articlemodel.dart';
import 'news.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({@required this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var articles = [];
  bool _loading = true;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: Image(
              image: AssetImage("assets/background2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      //padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ListView.builder(
                                itemCount: articles.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return BlogTile(
                                    imageUrl: articles[index].urlToImage,
                                    title: articles[index].title,
                                    desc: articles[index].description,
                                    url: articles[index].url,
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.2,
                  blurRadius: 1.0,
                  offset: Offset(1, 1))
            ]),
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0)),
              child: Image.network(imageUrl),
            ),
            Padding(
              padding: EdgeInsets.all(3.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                desc,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
