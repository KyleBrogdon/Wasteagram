import 'package:flutter/material.dart';

class FoodWasteDTO {
  DateTime date;
  String url;
  int quantity;
  double latitude;
  double longitude;
 

  FoodWasteDTO({required this.date, required this.url, required this.quantity, required this.latitude, required this.longitude});

    factory FoodWasteDTO.fromMap(dynamic postData) {
    return FoodWasteDTO(
      date: postData['date'],
      url: postData['url'],
      quantity: postData['quantity'],
      latitude: (postData['latitude']),
      longitude: (postData['longitude']),
    );
  }
}