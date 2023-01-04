import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'messaging/messaging.dart';

class search extends StatefulWidget {
  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final userref = FirebaseDatabase.instance.ref('Users');
  String searching = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leadingWidth: 22,
          title: Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text('    '),
                  Icon(Icons.search),
                  Text('  '),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.64,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searching = value;
                        });
                      },
                      autofocus: true,
                      cursorColor: Color.fromARGB(255, 116, 116, 116),
                      style: TextStyle(
                          fontSize: 17, color: Color.fromARGB(255, 68, 68, 68)),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
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
        body: Column(children: [
          SizedBox(
            height: 6,
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: userref,
                itemBuilder: (context, snapshot, animation, index) {
                  if ((snapshot
                          .child('username')
                          .value
                          .toString()
                          .toLowerCase()
                          .isNotEmpty &&
                      snapshot
                          .child('username')
                          .value
                          .toString()
                          .toLowerCase()
                          .contains(searching.toLowerCase()))) {
                    if (snapshot.child('id').value.toString() !=
                        auth.currentUser!.uid.toString()) {
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
                                        receiverid: snapshot
                                            .child('id')
                                            .value
                                            .toString(),
                                      ))));
                        },
                        leading: CircleAvatar(
                          maxRadius: 22.0,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              'https://icons.veryicon.com/png/o/miscellaneous/two-color-icon-library/user-286.png'),
                        ),
                        title:
                            Text(snapshot.child('username').value.toString()),
                      );
                    }
                  } else {
                    return Container();
                  }
                  return Container();
                }),
          ),
        ]));
  }
}
