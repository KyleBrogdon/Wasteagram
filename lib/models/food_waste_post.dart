import 'package:flutter/material.dart';

class FoodWastePost {
  final DateTime? date;
  final String? url;
  final int? quantity;
  final double? latitude;
  final double? longitude;
 

  FoodWastePost({this.date, this.url, this.quantity, this.latitude, this.longitude});

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