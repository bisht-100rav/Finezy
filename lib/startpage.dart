import 'package:finezy/firebaseauth/landingpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firebaseauth/landingpage.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  // ignore: non_constant_identifier_names
  Future<void> _anonymous_signin() async {
    /*
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    */
    // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      print("Error $e");
    } catch (e) {
      print("Error $e");
    }
  }

  var _bg = "assets/background2.jpg";
  // ignore: non_constant_identifier_names
  _Actionsheet(var context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          Container(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.redAccent, Colors.blueAccent]),
              ),
              child: CupertinoActionSheetAction(
                child: Text(
                  'Login In',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context1) => LandingPage()));
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.redAccent, Colors.blueAccent]),
            ),
            child: CupertinoActionSheetAction(
              child: const Text(
                'Skip',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 18),
              ),
              onPressed: _anonymous_signin,
              /*
                Navigator.push(context,
                    MaterialPageRoute(builder: (context1) => MainPage()));
                    */
            ),
          ),
        ],
        cancelButton: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            gradient:
                LinearGradient(colors: [Colors.redAccent, Colors.blueAccent]),
          ),
          child: CupertinoActionSheetAction(
            child: const Text(
              'Go back',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
            ),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          ),
        ),
      ),
    );
  }

  Widget titlepage(var context) {
    return Column(children: <Widget>[
      Flexible(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Text(
                  "Finezy",
                  style: TextStyle(
                      shadows: [
                        BoxShadow(
                            spreadRadius: 8,
                            blurRadius: 8,
                            color: Colors.white,
                            offset: Offset(0, 0))
                      ],
                      letterSpacing: 5.0,
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            Container(
              child: Center(
                child: Text(
                  "finance made easy",
                  style: TextStyle(
                      shadows: [
                        BoxShadow(
                            spreadRadius: 8,
                            blurRadius: 8,
                            color: Colors.blue,
                            offset: Offset(0, 0))
                      ],
                      letterSpacing: 3.0,
                      wordSpacing: 3.0,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      Flexible(
        child: Container(),
        flex: 2,
      ),
      Flexible(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            _Actionsheet(context);
          },
          child: Container(
            height: 50,
            width: 180,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0.002,
                      blurRadius: 5,
                      color: Colors.white,
                      offset: Offset(0, 0))
                ],
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(colors: [Colors.red, Colors.blue])),
            margin: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text("Get Started",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center),
          ),
        ),
      ),
    ]);
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
              image: AssetImage(_bg),
              fit: BoxFit.cover,
            ),
          ),
          titlepage(context),
        ],
      ),
    );
  }
}
