import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/food_waste_DTO.dart';
import 'package:wasteagram/screens/entry_lists.dart';
import 'package:wasteagram/screens/new_entry_screen.dart';
import 'package:wasteagram/screens/waste_detail_screen.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:location/location.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({Key? key}) : super(key: key);
  static const routeName = 'newEntry';

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final formKey = GlobalKey<FormState>();
  FoodWasteDTO fwDTO =
      FoodWasteDTO(date: DateTime.now(), url: 'a', quantity: 0, latitude: 0.0, longitude: 0.0);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as String;
    print("The arg is $args");
    fwDTO.url = args;
    return Scaffold(
        appBar: AppBar(
          title: Text('New Entry'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Column(children: [
            SizedBox(
              height: 200,
              width: 400,
              child: CachedNetworkImage(
                imageUrl: fwDTO.url,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 10),
            Form(
                key: formKey,
                child: Semantics(
                  label: 'Quantity entry for new post',
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: 'Please enter the quantity of food', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the quantity';
                      } else {
                        fwDTO.quantity = int.parse(value);
                        return null;
                      }
                    },
                    onSaved: (value) {
                      print('value is $value');
                      fwDTO.quantity = int.parse(value!);
                    },
                  ),
                )),
            SizedBox(height: 20),
          ]),
        ),
        floatingActionButton: Semantics(
          label: "Upload to Firebase button",
          child: ElevatedButton(
              child: Text('Upload your entry'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await uploadData(fwDTO);
                  Navigator.pushReplacementNamed(context, EntryLists.routeName);
                }
              }),
        ));
  }

  // Widget layout(context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 14),
  //     child: Column(children: [
  //       SizedBox(
  //         height: 200,
  //         width: 400,
  //         child: CachedNetworkImage(
  //           imageUrl: fwDTO.url,
  //           placeholder: (context, url) => CircularProgressIndicator(),
  //           errorWidget: (context, url, error) => Icon(Icons.error),
  //         ),
  //       ),
  //       SizedBox(height: 10),
  //       Form(
  //           key: formKey,
  //           child: TextFormField(
  //             inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
  //             autofocus: true,
  //             decoration: InputDecoration(
  //                 labelText: 'Please enter the quantity of food', border: OutlineInputBorder()),
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return 'Please enter the quantity';
  //               } else {
  //                 return null;
  //               }
  //             },
  //             onSaved: (value) {
  //               fwDTO.quantity = int.parse(value!);
  //             },
  //           )),
  //       SizedBox(height: 20),
  //     ]),
  //   );
  // }
}

Future<LocationData> retrieveLocation() async {
  var locationService = Location();
  LocationData locationData = await locationService.getLocation();
  return locationData;
}

Future<void> uploadData(fwDTO) async {
  LocationData location = await retrieveLocation();
  fwDTO.date = DateTime.now();
  fwDTO.latitude = location.latitude;
  fwDTO.longitude = location.longitude;
  FirebaseFirestore.instance.collection('posts').add({
    'date': fwDTO.date,
    'quantity': fwDTO.quantity,
    'url': fwDTO.url,
    'latitude': fwDTO.latitude,
    'longitude': fwDTO.longitude
  });
}
