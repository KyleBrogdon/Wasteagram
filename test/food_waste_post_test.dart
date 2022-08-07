import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';


void main() {
  test("post created from map", () {
    final date = DateTime.tryParse('2020-01-01');
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 20.0;
    final food_waste_post = FoodWastePost.fromMap({
      'date': date,
      'url': url,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    });

    expect(food_waste_post.date, date);
    expect(food_waste_post.url, url);
    expect(food_waste_post.quantity, quantity);
    expect(food_waste_post.latitude, latitude);
    expect(food_waste_post.longitude, longitude);
  });
}
