import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/screens/waste_detail_screen.dart';
import 'package:wasteagram/models/food_waste_post.dart';

class EntryLists extends StatefulWidget {
  @override
  _EntryListsState createState() => _EntryListsState();
}

// code citation: convert dateTime object to string
// https://stackoverflow.com/questions/51579546/how-to-format-datetime-in-flutter
class _EntryListsState extends State<EntryLists> {
  DateFormat dateFormat = DateFormat('EEEE, MMMM, yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wastegram'), centerTitle: true,),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data!.docs != null && snapshot.data!.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var count = snapshot.data!.docs.length;
                    var post = snapshot.data!.docs[count - 1 - index];
                    return ListTile(
                      title: Text(dateFormat.format(post['submission_date'].toDate()), style: TextStyle(fontSize: 20),),
                      subtitle: Text(post['weight'].toString(), textAlign: TextAlign.right, style: TextStyle(fontSize: 18),),
                      onTap: () {
                        Navigator.pushNamed(context, WasteDetailScreen.routeName,
                            arguments: post['submission_date']);
                      },
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: NewEntryButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/*
 * As an example I have added functionality to add an entry to the collection
 * if the button is pressed
 */
class NewEntryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('posts')
              .add({'submission_date': DateTime.now(), 'weight': 100});
        });
  }
}
