import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/account/myaccount.dart';
import 'package:flutterfire/login.dart';
import 'package:flutterfire/messaging/messaging.dart';
import 'package:flutterfire/messaging/messaging.dart';
import 'package:flutterfire/post/add_post.dart';
import 'package:flutterfire/post/imagepost.dart';
import 'package:flutterfire/post/add_post.dart';
import 'package:flutterfire/search.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final userref = FirebaseDatabase.instance.ref('Users');
  final msgref = FirebaseDatabase.instance.ref('Msg');

  String search1 = "";
  String edittext = "";
  String lastmsg = "";
  String rid = "";
  void showMyDialog(String title, String id) async {
    edittext = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          content: Container(
            child: TextField(
              onChanged: (value) {
                edittext = value;
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
                ref.child(id).update({'title': edittext}).then((value) {
                  setState(() {});
                }).onError((error, stackTrace) {
                  setState(() {});
                });
                Navigator.pop(context);
              },
              child: Text('Update'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     // image: AssetImage("assets/images/bulb.jpg"),
              //     // fit: BoxFit.cover,
              //   ),
              // ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      maxRadius: 36.0,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          'https://icons.veryicon.com/png/o/miscellaneous/two-color-icon-library/user-286.png'),
                    ),
                    Expanded(
                      child: FirebaseAnimatedList(
                          query: userref,
                          itemBuilder: (context, snapshot, animation, index) {
                            if (auth.currentUser!.uid ==
                                snapshot.child('id').value.toString()) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.child('username').value.toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    auth.currentUser!.email.toString(),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              );
                            } else {}
                            return Text('');
                          }),
                    ),
                  ]),
            )),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => myaccount()));
              },
              leading: Icon(Icons.account_circle),
              title: Text(
                'Account',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Spacer(),
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
            SizedBox(
              height: 10,
            ),
            Text(
              'Parth_Mi',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => search()));
        },
        child: Icon(Icons.message_outlined),
      ),
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Messager',
          style: TextStyle(),
        ),
      ),

      //
      //
      //
      //
      //
      //
      //
      body: Column(children: [
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => search()));
          },
          child: Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text('    '),
                  Icon(Icons.search),
                  Text('    '),
                  Text(
                    'Search',
                    style: TextStyle(
                        color: Color.fromARGB(255, 109, 109, 109),
                        fontSize: 17),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Color.fromARGB(255, 255, 255, 255),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 192, 192, 192), spreadRadius: 1),
              ],
            ),
            height: 40,
            width: MediaQuery.of(context).size.width * 0.89,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
            child: FirebaseAnimatedList(
                query: userref,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.child('id').value.toString() !=
                      auth.currentUser!.uid.toString()) {
                    rid = snapshot.child('id').value.toString();
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => messaging(
                                      senderid:
                                          auth.currentUser!.uid.toString(),
                                      receivername: snapshot
                                          .child('username')
                                          .value
                                          .toString(),
                                      receiverid:
                                          snapshot.child('id').value.toString(),
                                    ))));
                      },
                      leading: CircleAvatar(
                        maxRadius: 22.0,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            'https://icons.veryicon.com/png/o/miscellaneous/two-color-icon-library/user-286.png'),
                      ),
                      title: Text(
                        snapshot.child('username').value.toString(),
                      ),
                    );
                  }
                  return Container();
                })),
      ]),
    );
  }
}
