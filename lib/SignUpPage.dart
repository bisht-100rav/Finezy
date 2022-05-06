import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  // Alert Dialog Box
  Future<void> _showMyDialog(String _user) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Hello! $_user',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "please go back to previous page",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _createuser() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text);
      return _showMyDialog(_email.text);
    } on FirebaseAuthException catch (e) {
      print("Error $e");
    } catch (e) {
      print("Error $e");
    }
  }

  Widget _textfield(
      var _hinttxt, var _labeltxt, var _controller, bool _obscuretxt) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 50,
        width: 300,
        padding: EdgeInsets.all(2.0),
        child: TextField(
          obscureText: _obscuretxt,
          controller: _controller,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              hintText: _hinttxt,
              labelText: _labeltxt,
              labelStyle: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ClipRect(
              child: Image(
                image: AssetImage("assets/background2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              Padding(
                padding: EdgeInsets.only(bottom: 80.0),
                child: Container(),
              ),
              _textfield("abc@gmail.com", "email", _email, false),
              _textfield("abc@123", "password", _password, true),
              GestureDetector(
                onTap: () async {
                  _createuser();
                },
                child: Container(
                  height: 35,
                  width: 85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300]),
                  margin: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
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
