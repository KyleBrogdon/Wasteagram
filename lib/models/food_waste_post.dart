import 'package:flutter/material.dart';

class FoodWastePost {
  final String date;
  final String url;
  final String quantity;
  final String latitude;
  final String longitude;
 

  FoodWastePost({required this.date, required this.url, required this.quantity, required this.latitude, required this.longitude});

  factory FoodWastePost.fromMap(dynamic postData) {
    return FoodWastePost(
      date: postData['date'],
      url: postData['url'],
      quantity: postData['quantity'],
      latitude: (postData['latitude']),
      longitude: (postData['longitude']),
    );
  }
}