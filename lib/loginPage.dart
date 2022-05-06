import 'dart:async';
import 'package:finezy/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  // anonymous sign in
  Future<void> _login() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _email.text, password: _password.text);
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
              _textfield("Abc@123", "password", _password, true),
              Container(
                child: Center(
                  child: Text(
                    "forgot password?",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: _login,
                    child: Container(
                      height: 35,
                      width: 85,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0.34,
                                blurRadius: 2,
                                color: Colors.white,
                                offset: Offset(0, 0))
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300]),
                      margin: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          'login',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignPage()));
                    },
                    child: Container(
                      height: 35,
                      width: 85,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0.34,
                                blurRadius: 2,
                                color: Colors.white,
                                offset: Offset(0, 0))
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300]),
                      margin: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          'sign-up',
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
        ],
      ),
    );
  }
}
