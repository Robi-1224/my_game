import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:my_game/Game/My_game.dart';

class Player extends SpriteComponent with HasGameReference<MyGame>,CollisionCallbacks{
  // variables
  bool isGrounded =true;
  bool jumpPressed =false;
  double jumpForce =-700;
  double velocity = 0;
  final double gravity =1200;
  int lives = 3;
  
// initialize variables who need components
@override
  FutureOr<void> onLoad()async{
     await super.onLoad();
     sprite = await Sprite.load("player.png");
     size = Vector2.all(100);
     position = Vector2(0,(game.size.y/2) -(size.y/2));
     anchor = Anchor.center;
     add(RectangleHitbox());
  }

@override
  void update(double dt) {
    super.update(dt);
     // checks if player is on the ground then sets the player grounded
   if(position.y > (game.size.y/2) - (size.y/2)){
    position.y = (game.size.y/2) - (size.y/2);
    isGrounded =true;
    velocity = 0;
   }
    // checks if player pressed jump and can jump, then adds an upwards force to player.
   if(jumpPressed&&isGrounded){
      FlameAudio.play(MyGame.jumpSfx);
      velocity= jumpForce;
      jumpPressed =false;
      isGrounded = false;
    }
     // simulates gravity
    velocity += gravity * dt;
    position.y +=velocity *dt;
  }

  void Dead(){
    game.GameOver();
    removeFromParent();
  }
} 