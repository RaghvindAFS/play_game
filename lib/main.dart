import 'package:flutter/material.dart';
import 'screens/signUp.dart';
import 'package:play_game/screens/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String> data;
  bool page = false;

  // This widget is the root of your application.
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> checkDetails() async {
    final SharedPreferences prefs = await _prefs;
    data = prefs.getStringList('data') ?? [];
    print('data $data');
    if (data.isNotEmpty) {
      page = true;
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDetails();
    Future.delayed(Duration(milliseconds: 100), () {
      // Do something
    });

  }

  @override
  Widget build(BuildContext context) {
    print(page);
    return page
        ? GamePage() : SignUpPage();
  }
}
