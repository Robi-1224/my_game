
import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_game/Game/livesText.dart';
import 'package:my_game/Game/my_game_world.dart';
import 'package:my_game/Game/resetButton.dart';


class MyGame extends FlameGame<MyGameWorld>with KeyboardEvents,HasCollisionDetection{
  ResetButton? resetButton;
  bool reset = false;
  bool musicStarted =false;
  static const jumpSfx ='jump.mp3';
  static const loopMusic ='background.mp3';
  static const hurtSfx ='hurt.mp3';

  MyGame() : super(
    world: MyGameWorld()
);

  @override FutureOr<void> onLoad()async {
    await super.onLoad();
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([jumpSfx,loopMusic,hurtSfx]);
    camera.viewport =FixedResolutionViewport(resolution: Vector2(size.x,size.y)); 
    world.playerReady = (){
      camera.viewport.add(LivesText(world.player));
      camera.viewport.add(world.scoresystem);
    };
    await StartGame();
  }

  Future<void> StartGame()async{
    resetButton?.removeFromParent();
    resetButton =null;
    await world.Start();
  }
  
  void GameOver(){
    world.Stop();
    resetButton ??= ResetButton();

    if(!resetButton!.isMounted){
    resetButton?.position = camera.viewport.virtualSize/2;
    camera.viewport.add(resetButton!);
    }
  }
  
  void ResetGame(){
    resetButton!.removeFromParent();
    resetButton = null;
    reset = true;
    world.Start();
  }
 @override KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) { 
  if(event is KeyDownEvent){ 
  if(!musicStarted){
    FlameAudio.bgm.play(MyGame.loopMusic);
    musicStarted = true;
  }
  if(keysPressed.contains(LogicalKeyboardKey.space)&&world.player.isGrounded){ 
      world.player.jumpPressed = true; 
     return KeyEventResult.handled;
    } 
    } 
      return KeyEventResult.ignored; 
    } 
 }
  