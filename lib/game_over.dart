import 'package:flame/sprite.dart';
import 'package:flappybird/game.dart';
import 'package:flappybird/score.dart';
import 'package:flutter/material.dart';

class GameOver {
  Rect go;
  Sprite goSprite;
  BirdGame birdGame;
  BuildContext ctx;

  GameOver(BirdGame birdGame) {
    this.birdGame = birdGame;
    go = Rect.fromLTWH(birdGame.tileSize * 3, birdGame.screenSize.height / 2,
        birdGame.tileSize * 4, birdGame.tileSize * 2);
    goSprite = Sprite('retry.png');
  }

  void render(Canvas canvas, Score score) {
    goSprite.renderRect(canvas, go);
    score.render(canvas);
  }

  void onTap(TapDownDetails evt, Function callback) {
    if (go.contains(evt.globalPosition)) {
      print("GameOver onTap");
      callback.call(GameScreen.START);
    }
  }
}
