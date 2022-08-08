import 'package:flutter/material.dart';
import 'screens/entry_lists.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wasteagram/screens/waste_detail_screen.dart';
import 'package:wasteagram/screens/new_entry_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  

  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => AppState();

  static AppState of(BuildContext context) => context.findAncestorStateOfType<AppState>()!;
  static final routes = {
    WasteDetailScreen.routeName: (context) => WasteDetailScreen(),
    EntryLists.routeName: (context) => EntryLists(),
    NewEntryScreen.routeName: (context) => NewEntryScreen(),
  };
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        routes: App.routes,
        home: Scaffold(body: EntryLists()));
  }
}
