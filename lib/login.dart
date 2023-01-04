import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/home.dart';
import 'package:flutterfire/signup.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  String error1 = "";

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
      setState(() {
        error1 = "please wait...";
      });
    }).onError((error, stackTrace) {
      setState(() {
        error1 = error.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Flutter Fire',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w700, color: Colors.blue),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Form(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                // Text(
                //   'Flutter Fire',
                //   style: TextStyle(
                //       fontSize: 35,
                //       fontWeight: FontWeight.w700,
                //       color: Colors.blue),
                // ),
                SizedBox(
                  height: 75,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 139, 139, 139)),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Email'),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Password'),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Forgot password ?'),
                        TextButton(
                          onPressed: () {},
                          child: Text('Click here'),
                        )
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 35,
                  decoration: BoxDecoration(),
                  child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 260,
                  child: Center(
                    child: Text(
                      error1,
                      style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not have an Account ?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signup()));
                          },
                          child: Text('Sign Up'),
                        )
                      ]),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
