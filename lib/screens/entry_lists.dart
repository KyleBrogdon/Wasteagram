import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/screens/camera_screen.dart';
import 'package:wasteagram/screens/new_entry_screen.dart';
import 'package:wasteagram/screens/waste_detail_screen.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

File? image;
final picker = ImagePicker();

class EntryLists extends StatefulWidget {
  @override
  _EntryListsState createState() => _EntryListsState();
  static const routeName = 'entryList';
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
                    var post = snapshot.data!.docs[count - index - 1];
                    FoodWastePost entry = FoodWastePost(
                        date: dateFormat.format(post['date'].toDate()),
                        url: post['url'],
                        quantity: post['quantity'].toString(),
                        latitude: post['latitude'].toString(),
                        longitude: post['longitude'].toString());
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
                        Navigator.pushNamed(context, WasteDetailScreen.routeName, arguments: entry);
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

Future getImageCamera() async {
  var pickedFile = await picker.pickImage(source: ImageSource.gallery);
  print('pf is $pickedFile');
  image = File(pickedFile!.path);
  var fileName = DateTime.now().toString() + '.jpg';
  Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
  UploadTask uploadTask = storageReference.putFile(image!);
  await uploadTask;
  final url = await storageReference.getDownloadURL();
  print('url in getImage entryLists is $url');
  return url;
}

Future getImageGallery() async {
  var pickedFile = await picker.pickImage(source: ImageSource.gallery);
  image = File(pickedFile!.path);
  var fileName = DateTime.now().toString() + '.jpg';
  Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
  UploadTask uploadTask = storageReference.putFile(image!);
  await uploadTask;
  final url = await storageReference.getDownloadURL();
  return url;
}

/*
 * As an example I have added functionality to add an entry to the collection
 * if the button is pressed
 */
class NewEntryButton extends StatelessWidget {
  var url;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.camera_enhance_outlined),
        onPressed: () async {
          await showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                    actions: [
                      CupertinoActionSheetAction(
                          onPressed: () async {
                            url = await getImageCamera();
                            Navigator.pushNamed(context, NewEntryScreen.routeName, arguments: url);
                          },
                          child: Text('Select from Camera')),
                      CupertinoActionSheetAction(
                          onPressed: () async {
                            url = await getImageGallery();
                            Navigator.pushNamed(context, NewEntryScreen.routeName, arguments: url);
                          },
                          child: Text('Select from Gallery'))
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      child: Text('Cancel'),
                      onPressed: () => {Navigator.pop(context)},
                    ),
                  ));
          // Navigator.pushNamed(context, CameraScreen.routeName);
          // FirebaseFirestore.instance
          //     .collection('posts')
          //     .add({'date': DateTime.now(), 'quantity': 100, 'url': 'test', 'latitude': '72.00', 'longitude': '55.00'});;
        });
  }
}
