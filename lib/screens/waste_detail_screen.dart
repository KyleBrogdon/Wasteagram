import 'package:flutter/material.dart';
import 'package:wasteagram/models/food_waste_post.dart';

class WasteDetailScreen extends StatelessWidget {
  final FoodWastePost? post;

  static const routeName = 'wasteDetails';

  const WasteDetailScreen({Key? key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    print(args);
    return Scaffold(appBar: AppBar(title: Text('Wasteagram')), body: layout());
  }

  Widget layout() {
    return Column(children: [Text('todo'), SizedBox(height: 20), Placeholder()]);
  }
}
