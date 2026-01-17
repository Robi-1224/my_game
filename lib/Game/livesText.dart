import 'package:flame/components.dart';
import 'package:my_game/Game/sprites/Player.dart';

class LivesText extends TextComponent{
  final Player player;

  LivesText(this.player):super(
    position: Vector2(16, 16),
    anchor: Anchor.topLeft,
    priority: 100,
  );

  @override
  void update(double dt) {
    super.update(dt);
    text ='Lives: ${player.lives}';
  }
}