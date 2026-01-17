import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:my_game/Game/My_game.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final MyGame game;

  @override void initState() {
    super.initState();
    game = MyGame();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner:false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.green
    ),
    home: Scaffold(
      body:SizedBox(
      child: GameWidget(game: game,autofocus: true),
      width:1920,
      height:1080/2,
    )));
  }
}