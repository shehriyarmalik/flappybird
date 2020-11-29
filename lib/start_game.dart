import 'package:flame/sprite.dart';
import 'package:flappybird/game.dart';
import 'package:flutter/material.dart';

class StartGame {
  Rect startButton;
  Sprite startSprite;
  BirdGame birdGame;

  StartGame(BirdGame birdGame) {
    this.birdGame = birdGame;
    startButton = Rect.fromLTWH(
        birdGame.tileSize * 3,
        birdGame.screenSize.height / 2,
        birdGame.tileSize * 4,
        birdGame.tileSize * 2);
    startSprite = Sprite('start.png');
  }

  void render(Canvas canvas) {
    startSprite.renderRect(canvas, startButton);
  }

  void onTap(TapDownDetails evt, Function callback) {
    if (startButton.contains(evt.globalPosition)) {
      callback.call(GameScreen.PLAYING);
    }
  }
}
