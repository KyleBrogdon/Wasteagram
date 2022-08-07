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
    return Scaffold(
        appBar: AppBar(
          title: Text('Wasteagram'),
          centerTitle: true,
        ),
        body: layout(args));
  }

  Widget layout(args) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(children: [
        Text(
          args.date,
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        Placeholder(),
        SizedBox(height: 20),
        Text('Quantity: ${args.quantity}', style: TextStyle(fontSize: 20)),
        SizedBox(height: 20),
        Text('(${args.latitude}, ${args.longitude})', style: TextStyle(fontSize: 20)),
      ]),
    );
  }
}
