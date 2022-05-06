import 'package:finezy/firebase_database/database.dart';
import 'package:finezy/profile.dart';
import 'package:finezy/stockspage/stockspage.dart';
import 'package:flutter/material.dart';
import 'helper/category.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageindex = 0;
  // ignore: missing_return
  Widget getappbar() {
    if (pageindex == 0) {
      return AppBar(
        backgroundColor: Colors.black,
        title: Text("Stock list"),
      );
    } else if (pageindex == 1) {
      return AppBar(
        backgroundColor: Colors.black,
        title: Text("Trending News - Business"),
      );
    } else if (pageindex == 2) {
      return AppBar(
        backgroundColor: Colors.black,
        title: Text("Stocks"),
      );
    } else if (pageindex == 3) {
      return AppBar(
        backgroundColor: Colors.black,
        title: Text("Profile"),
      );
    }
  }

  Widget getbottombar() {
    List bottomimg = [
      pageindex == 0
          ? "assets/images/home_color.png"
          : "assets/images/home.png",
      pageindex == 1
          ? "assets/images/news_outlined.png"
          : "assets/images/news.png",
      pageindex == 2
          ? "assets/images/chart_outline.png"
          : "assets/images/chart.png",
      pageindex == 3
          ? "assets/images/person_outline.png"
          : "assets/images/profile.png",
    ];
    selectedtab(index) {
      setState(() {
        pageindex = index;
      });
    }

    return BottomAppBar(
        child: Container(
      height: 50,
      width: double.infinity,
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < bottomimg.length; i++)
              (InkWell(
                onTap: () {
                  selectedtab(i);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 25.0, right: 25.0),
                  height: 25,
                  width: 23,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          bottomimg[i],
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
              )),
          ],
        ),
      ),
    ));
  }

  Widget getbody() {
    List<Widget> bodypages = [
      // Stocks Page
      StocksPage(),

      // NEWS page
      CategoryNews(category: "Business"),

      // Sentiment Page
      //Container(child: Text("s")),
      Sentiment(),
      // Profile Page
      ProfilePage(),
    ];

    return IndexedStack(index: pageindex, children: bodypages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getappbar(),
      body: getbody(),
      bottomNavigationBar: getbottombar(),
    );
  }
}
