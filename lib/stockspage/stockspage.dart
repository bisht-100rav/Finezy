import 'dart:convert';
import 'package:finezy/firebase_database/database.dart';
import 'package:finezy/firebase_database/stockmodel.dart';
import 'package:flutter/material.dart';

class StocksPage extends StatefulWidget {
  @override
  _StocksPageState createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  List<Stock> stocks = [];

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        stocks = list.map((model) => Stock.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  var _bg = "assets/background2.jpg";

  Widget background() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(_bg), fit: BoxFit.cover)),
    );
  }

  Widget mainbody() {
    _stockin(var index) {
      const List stock_in = [
        "assets/images/greenarrow.png",
        "assets/images/redarrow.png"
      ];
      if (stocks[index].trend == "UP") {
        return stock_in[0];
      } else {
        return stock_in[1];
      }
    }

    if (stocks.isNotEmpty) {
      return Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(left: 7.0, right: 7.0, bottom: 4.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 10, top: 20.0, left: 10.0, right: 10.0),
                      child: Text(
                        "Stocks",
                        style: TextStyle(
                            letterSpacing: 6.0,
                            fontSize: 38,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 18.0),
                      child: Text(
                        "trending",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.90),
                            letterSpacing: 10.0,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 7,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    for (int i = 0; i < stocks.length; i++)
                      (Container(
                        margin: EdgeInsets.all(5.0),
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 0.5,
                                  spreadRadius: 0.002,
                                  color: Colors.grey,
                                  offset: Offset(0.2, 0.2))
                            ]),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                stocks[i].symbol,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                "${stocks[i].open.toString()} USD",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${stocks[i].percent.toString()}%",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image(
                                      image: AssetImage(_stockin(i)),
                                      fit: BoxFit.contain,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ))
                  ],
                ),
              ))
        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          background(),
          mainbody(),
        ],
      ),
    );
  }
}
