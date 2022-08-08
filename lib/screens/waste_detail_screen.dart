import 'package:cached_network_image/cached_network_image.dart';
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
        SizedBox(
              height: 200,
              width: 400,
              child: CachedNetworkImage(
                imageUrl: args.url,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
        SizedBox(height: 20),
        Text('Quantity: ${args.quantity}', style: TextStyle(fontSize: 20)),
        SizedBox(height: 20),
        Text('(${args.latitude}, ${args.longitude})', style: TextStyle(fontSize: 20)),
      ]),
    );
  }
}
