import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class post1 extends StatefulWidget {
  @override
  State<post1> createState() => _postState();
}

class _postState extends State<post1> {
  String postcontroller = "";
  final databaseref = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Add Post',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              onChanged: ((value) {
                postcontroller = value;
              }),
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: 'What is in your mind?',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  String pid = DateTime.now().millisecondsSinceEpoch.toString();
                  databaseref.child(pid).set({
                    'id': pid,
                    'title': postcontroller.toString()
                  }).then((value) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: const Text('Post added successfully'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'OK',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).onError((error, stackTrace) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: const Text('Fail to add post'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'OK',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                },
                child: Text('Add')),
          ],
        ),
      ),
    );
  }
}
