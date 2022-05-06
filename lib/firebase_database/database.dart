import 'dart:async';
import 'dart:convert';

import 'package:finezy/firebase_database/stockmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API {
  static Future getUsers() {
    return http.get(
        "https://finezylogin-default-rtdb.firebaseio.com/-MVdRvDOkGcJ7fwwuika/data.json");
  }
}

class Sentiment extends StatefulWidget {
  @override
  _SentimentState createState() => _SentimentState();
}

class _SentimentState extends State<Sentiment> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView.builder(
          itemCount: stocks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    stocks[index].symbol,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    stocks[index].open.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
