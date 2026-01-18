import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/animation.dart';
import 'package:my_game/Game/My_game.dart';
import 'package:my_game/Game/scoreSystem.dart';
import 'package:my_game/Game/sprites/Player.dart';
import 'package:my_game/Game/sprites/background.dart';
import 'package:my_game/Game/sprites/obstacle.dart';

class MyGameWorld extends World with HasGameReference<MyGame>{
  late final Player player;
  late final Scoresystem scoresystem;
  late TimerComponent spawnTimer;
  final List<Obstacle> obstacles = [];
  VoidCallback? playerReady;

  Future<void> Start()async{
    removeAll(children.toList());
    if(!game.reset){
      player =Player();
      scoresystem = Scoresystem();
    }
    await add(Background());
    await add(player);
    scoresystem.score = 0;
    player.lives =3;
    playerReady?.call();

    spawnTimer = TimerComponent(period: 2,repeat: true,onTick: spawnObstacle);
    add(spawnTimer);
  }

  void Stop(){
    spawnTimer.removeFromParent();
  }

   void spawnObstacle() {
    Obstacle obstacle =Obstacle(spawnPosition: Vector2(game.size.x + 50,game.size.y /2));
    add(obstacle);
    obstacles.add(obstacle);
   }
}
