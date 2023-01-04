import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class messaging1 extends StatefulWidget {
  String rid = "";
  String sid = "";
  String rname = "";
  String message = "";

  messaging1(
      {required this.rid,
      required this.rname,
      required this.sid,
      required this.message});
  @override
  State<messaging1> createState() => _messaging1State();
}

class _messaging1State extends State<messaging1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Text(widget.rid),
        Text(widget.rname),
        Text(widget.message),
        Text(widget.sid),
      ]),
    );
  }
}






//
//
//
// final logic of chatapplication in flutter and firebase
//  Expanded(
//           child: FirebaseAnimatedList(
//               query: msgref,
//               itemBuilder: (context, snapshot, animation, index) {
//                 if (((snapshot.child('senderid').value.toString() ==
//                             widget.senderid) &&
//                         (snapshot.child('receiverid').value.toString() ==
//                             widget.receiverid)) ||
//                     (snapshot.child('receiverid').value.toString() ==
//                             widget.senderid) &&
//                         (snapshot.child('senderid').value.toString() ==
//                             widget.receiverid)) {
//                   return ListTile(
//                     onTap: () {},
//                     title: Text(snapshot.child('message').value.toString()),
//                   );
//                 }
//                 return Container();
//               }),
//         ),