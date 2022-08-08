import 'package:flutter/material.dart';

class FoodWasteDTO {
  DateTime date;
  String url;
  int quantity;
  double latitude;
  double longitude;
 

  FoodWasteDTO({required this.date, required this.url, required this.quantity, required this.latitude, required this.longitude});
}