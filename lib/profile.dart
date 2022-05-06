import 'package:finezy/randompage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List profile_txt = ["Settings", "About", "Support", "Call us"];

  Widget _profilecontainers(String _txt) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 0.5,
                  spreadRadius: 0.002,
                  color: Colors.grey,
                  offset: Offset(0.2, 0.2)),
            ],
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: 70,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child:
                Text(_txt, style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  logo() {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(left: 7.0, right: 7.0, bottom: 4.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 0.5,
                spreadRadius: 0.002,
                color: Colors.grey,
                offset: Offset(0.2, 0.2)),
          ],
          gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.grey[200], shape: BoxShape.circle),
              height: 130,
              width: 130,
              child: Icon(
                Icons.person,
                size: 92,
              ),
            ),
          ),
          Center(
            child: Text(
              "Itachi",
              style: TextStyle(
                letterSpacing: 8.0,
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: _height,
            width: _width,
            child: Image.asset("assets/background2.jpg", fit: BoxFit.cover),
          ),
          Column(
            children: <Widget>[
              Flexible(flex: 3, child: logo()),
              Flexible(
                flex: 5,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      for (int i = 0; i < profile_txt.length; i++)
                        (_profilecontainers(profile_txt[i])),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 0.5,
                                    spreadRadius: 0.002,
                                    color: Colors.grey,
                                    offset: Offset(0.2, 0.2)),
                              ],
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("Log out",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
