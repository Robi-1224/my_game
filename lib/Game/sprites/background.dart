import 'dart:async';

import 'package:flame/components.dart';
import 'package:my_game/Game/My_game.dart';

class Background extends SpriteComponent with HasGameReference<MyGame>{

@override
  FutureOr<void> onLoad()async {
    await super.onLoad();
    sprite =await Sprite.load("background.jpg");
    size = game.size;
    position =game.camera.viewfinder.position;
    anchor = Anchor.center;
    priority = -100;
  }
}