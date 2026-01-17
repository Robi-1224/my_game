import 'dart:async';
import 'package:flame/components.dart';
import 'package:my_game/Game/My_game.dart';
import 'package:my_game/Game/sprites/obstacle.dart';

class Scoresystem extends TextComponent with HasGameReference<MyGame>{
  int score =0;
  Scoresystem():super(
    anchor: Anchor.topRight,
    priority: 100,
    text:"Score: 0"
    );

  @override FutureOr<void> onLoad()async {
    await super.onLoad();
    position = Vector2(game.camera.viewport.size.x -16,16);
  }
  @override void update(double dt) {
    super.update(dt);
    CheckScore(game.world.obstacles);
  }

  void CheckScore(List<Obstacle> obstacles){
    for(final Obstacle in obstacles){
      if(Obstacle.scored) continue;

      final playerX = game.world.player.position.x;
      final obstacleX = Obstacle.position.x;

      if(playerX > obstacleX){
        Obstacle.scored = true;
        score++;
        text ="Score: ${score}";
      }
    }
  }
}