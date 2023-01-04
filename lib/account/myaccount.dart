import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../login.dart';

class myaccount extends StatefulWidget {
  @override
  State<myaccount> createState() => _myaccountState();
}

class _myaccountState extends State<myaccount> {
  final auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.ref('Post');

  final userref = FirebaseDatabase.instance.ref('Users');
  String userid = "";
  String edituser = "";
  void edit(String userid) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: Container(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Username',
              ),
              onChanged: (value) {
                edituser = value;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userref
                      .child(auth.currentUser!.uid.toString())
                      .update({'username': edituser}).then((value) {
                    setState(() {});
                  }).onError((error, stackTrace) {
                    setState(() {});
                  });
                  Navigator.pop(context);
                });
              },
              child: Text('Done'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Account'),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 56.0,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          'https://icons.veryicon.com/png/o/miscellaneous/two-color-icon-library/user-286.png'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Container(
                        width: 80,
                        child: TextButton(
                            onPressed: () {
                              edit(userid);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  'Edit',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: FirebaseAnimatedList(
                    query: userref,
                    itemBuilder: (context, snapshot, animation, index) {
                      userid = snapshot.child('id').value.toString();
                      if (auth.currentUser!.uid ==
                          snapshot.child('id').value.toString()) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.child('username').value.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Email',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              auth.currentUser!.email.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        );
                      } else {}
                      return Text('');
                    }),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  width: 110,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color.fromARGB(255, 238, 238, 238),
                        foregroundColor: Colors.black),
                    child: Row(
                      children: [
                        Icon(Icons.logout_outlined),
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    onPressed: () {
                      auth.signOut().then((value) => Navigator.of(context)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => login()),
                              (route) => false));
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
