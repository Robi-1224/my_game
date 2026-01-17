import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:my_game/Game/My_game.dart';
import 'package:my_game/Game/sprites/Player.dart';


class Obstacle extends SpriteComponent with HasGameReference<MyGame>,CollisionCallbacks{
final int speed = 500; 
bool scored = false;
 Obstacle({required Vector2 spawnPosition}) {
    position = spawnPosition.clone();
 }
  // initialize variables who need components
@override
  FutureOr<void> onLoad()async{
     await super.onLoad();
     sprite = await Sprite.load("obstacle.png");
     size = Vector2.all(100);
     position = Vector2((game.size.x/2) - (size.x/2),(game.size.y/2) - (size.y/2));
     anchor = Anchor.center;
     add(RectangleHitbox()); 
  }

  @override
  void update(double dt) {
    super.update(dt);
     if(position.x > (-game.size.x/2) - (size.x/2)){
        position.x -= speed * dt;
     }else{
         removeFromParent();
     }
  }

 @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
     if(other is Player){
      HitPlayer(other);
    }
  }

  void HitPlayer(PositionComponent other){
    FlameAudio.play(MyGame.hurtSfx);
    game.world.player.lives--;
    removeFromParent();
    if(game.world.player.lives <= 0){
      other.removeFromParent();
      game.world.player.Dead();
    }
  }
}