import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfire/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseref = FirebaseDatabase.instance.ref('Users');

  String email = "";
  String password = "";
  String success = "";
  String username = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text('Sign up'),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Username'),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
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
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Password'),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 35,
                decoration: BoxDecoration(),
                child: ElevatedButton(
                  onPressed: () {
                    //
                    //
                    //
                    //signup
                    _auth
                        .createUserWithEmailAndPassword(
                            email: email, password: password)
                        .then((value) {
                      String pid = _auth.currentUser!.uid.toString();
                      databaseref
                          .child(pid)
                          .set({'id': pid, 'username': username.toString()})
                          .then(((value) {}))
                          .onError(((error, stackTrace) {}));
                    }).onError((error, stackTrace) => null);

                    setState(() {
                      success = "Register successfully";
                    });
                    //
                    //
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'signup',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: 260,
                  child: Center(
                      child: Text(
                    success,
                    style: TextStyle(color: Colors.green),
                  ))),
              SizedBox(
                height: 5,
              ),
              Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Already have an Account ?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Login'),
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
    );
  }
}
