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
  DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wastegram'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data!.docs != null && snapshot.data!.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var count = snapshot.data!.docs.length;
                    var post = snapshot.data!.docs[count - 1 - index];
                    FoodWastePost entry = FoodWastePost(
                      date: dateFormat.format(post['date'].toDate()), url: 'fakeurl', quantity: post['quantity'].toString(), latitude: post['latitude'].toString(), longitude: post['longitude'].toString() 
                    );
                    return ListTile(
                      title: Text(
                        entry.date,
                        style: TextStyle(fontSize: 26),
                      ),
                      subtitle: Text(
                        entry.quantity,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 26),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, WasteDetailScreen.routeName,
                            arguments: entry);
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
              .add({'date': DateTime.now(), 'quantity': 100, 'url': 'test', 'latitude': '72.00', 'longitude': '55.00'});
        });
  }
}
