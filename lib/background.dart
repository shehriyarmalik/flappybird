import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flappybird/game.dart';

class Background {
  Sprite bgSprite;
  Rect bgRect;
  Paint bgPaint;

  Background(BirdGame game) {
    bgRect = Rect.fromLTWH(
      0,
      0,
      game.screenSize.width * 2.5,
      game.screenSize.height,
    );
    bgSprite = Sprite('background.png');
  }

  void render(Canvas canvas) {
    bgSprite.renderRect(canvas, bgRect);
  }
}
