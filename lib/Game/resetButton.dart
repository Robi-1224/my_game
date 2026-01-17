import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:my_game/Game/My_game.dart';

class ResetButton extends ButtonComponent with HasGameReference<MyGame> {

  ResetButton()
      : super(
          anchor: Anchor.center,
          priority: 1000,
          size: Vector2(150,50)
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Create the text label as a child
    button = TextComponent(
      text: "Retry",
      anchor: Anchor.center
    );
    button?.position =size/2;
  }
  @override
  void Function()? get onPressed => game.ResetGame;
}