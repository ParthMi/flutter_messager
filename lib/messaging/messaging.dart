import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../post/chatmessage.dart';

class messaging extends StatefulWidget {
  String senderid = "";
  String receivername = "";
  String receiverid = "";
  messaging({
    required this.senderid,
    required this.receivername,
    required this.receiverid,
  });

  @override
  State<messaging> createState() => _messagingState();
}

class _messagingState extends State<messaging> {
  final auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.ref('Post');

  final userref = FirebaseDatabase.instance.ref('Users');

  final msgref = FirebaseDatabase.instance.ref('Msg');
  String message = "";
//
//
//
  ScrollController listScrollController = new ScrollController();

  final databaseref = FirebaseDatabase.instance.ref('Post');
  bool _needsScroll = false;
//
//
// scroll new

  Future<void> scroll() async {
    listScrollController.animateTo(
      listScrollController.position.maxScrollExtent,
      duration: Duration(microseconds: 10),
      curve: Curves.easeOut,
    );
  }

  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => scroll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leadingWidth: 22,
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 23.0,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://icons.veryicon.com/png/o/miscellaneous/two-color-icon-library/user-286.png'),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.receivername,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      //  Text(widget.senderid),
      body: Column(children: [
        Expanded(
            child: FirebaseAnimatedList(
                controller: listScrollController,
                query: msgref,
                itemBuilder: (context, snapshot, animation, index) {
                  if (((snapshot.child('senderid').value.toString() ==
                              widget.senderid) &&
                          (snapshot.child('receiverid').value.toString() ==
                              widget.receiverid)) ||
                      (snapshot.child('receiverid').value.toString() ==
                              widget.senderid) &&
                          (snapshot.child('senderid').value.toString() ==
                              widget.receiverid)) {
                    //
                    //
                    //

                    //
                    //
                    //
                    return ListTile(
                        title: Align(
                            alignment: ((snapshot
                                        .child('receiverid')
                                        .value
                                        .toString() ==
                                    widget.receiverid)
                                ? Alignment.bottomRight
                                : Alignment.bottomLeft),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ((snapshot
                                            .child('receiverid')
                                            .value
                                            .toString() ==
                                        widget.receiverid)
                                    ? Colors.grey.shade200
                                    : Colors.blue[200]),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(
                                snapshot.child('message').value.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            )));
                  }

                  return Container();
                })),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Color.fromARGB(255, 253, 253, 253),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        scroll();

                        message = value;
                      });
                    },
                    onTap: () {
                      Timer(Duration(milliseconds: 600), () {
                        scroll();
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                    controller: fieldText,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      String mid =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      msgref.child(mid).set({
                        'senderid': widget.senderid.toString(),
                        'receiverid': widget.receiverid.toString(),
                        'message': message.toString()
                      }).then((value) {
                        scroll();
                      });
                      scroll();
                      clearText();
                    });
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 25,
                  ),
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}




// child: ListView.builder(
//               itemCount: messages.length,
//               shrinkWrap: true,
//               padding: EdgeInsets.only(top: 10, bottom: 80),
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Align(
//                     alignment: (messages[index].messageType == "receiver"
//                         ? Alignment.bottomLeft
//                         : Alignment.bottomRight),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: (messages[index].messageType == "receiver"
//                             ? Colors.grey.shade200
//                             : Colors.blue[200]),
//                       ),
//                       padding: EdgeInsets.all(16),
//                       child: Text(
//                         messages[index].messageContent,
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),








    // Expanded(
    //         child: FirebaseAnimatedList(
    //             query: msgref,
    //             itemBuilder: (context, snapshot, animation, index) {
    //               if (snapshot.child('senderid').value == widget.senderid) {
    //                 return ListTile(
    //                     title: Align(
    //                         alignment: ((snapshot
    //                                     .child('receiverid')
    //                                     .value
    //                                     .toString() ==
    //                                 widget.receiverid)
    //                             ? Alignment.bottomRight
    //                             : Alignment.bottomLeft),
    //                         child: Container(
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(20),
    //                             color: ((snapshot
    //                                         .child('receiverid')
    //                                         .value
    //                                         .toString() ==
    //                                     widget.receiverid)
    //                                 ? Colors.grey.shade200
    //                                 : Colors.blue[200]),
    //                           ),
    //                           padding: EdgeInsets.all(16),
    //                           child: Text(
    //                             snapshot.child('message').value.toString(),
    //                             style: TextStyle(fontSize: 15),
    //                           ),
    //                         )));
    //               }

    //               return Container();
    //             })),
     