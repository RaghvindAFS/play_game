import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Game') ),
      body:const Center(child: Text('Wait for Game Bro!',style: TextStyle(fontSize: 30,color: Colors.blueAccent),)) 
      ,
    );
  }
}