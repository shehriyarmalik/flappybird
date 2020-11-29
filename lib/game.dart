import 'dart:ui';
import 'package:flame/gestures.dart';

import 'package:flame/game.dart';
import 'package:flame/flame.dart';

import 'package:flappybird/background.dart';
import 'package:flappybird/game_over.dart';
import 'package:flappybird/pipe.dart';
import 'package:flappybird/pipe_spawner.dart';
import 'package:flappybird/score.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'start_game.dart';

import 'bird.dart';

enum GameScreen { START, PLAYING, GAME_OVER }

class BirdGame extends Game with TapDetector {
  Size screenSize;
  Background background;
  Bird bird;
  Pipe pipe;
  double tileSize;
  PipeSpawner pipeSpawner;
  GameOver go;
  GameScreen gs;
  StartGame sg;
  Score score;

  BirdGame() {
    initialize();
  }

  initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    var size = await Flame.util.initialDimensions();
    this.screenSize = size;
    this.tileSize = screenSize.width / 10;
    background = Background(this);
    bird = Bird(this);
    score = Score(this);
    pipeSpawner = PipeSpawner(this);
    go = GameOver(this);
    sg = StartGame(this);
    gs = GameScreen.START;
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
    if (gs == GameScreen.START) {
      sg.render(canvas);
    } else if (gs == GameScreen.PLAYING) {
      if (!bird.isDead) {
        bird.render(canvas);
        pipeSpawner.render(canvas);
        score.render(canvas);
      } else {
        gs = GameScreen.GAME_OVER;
      }
    } else {
      go.render(canvas, score);
    }
  }

  @override
  void update(double t) {
    if (gs == GameScreen.PLAYING) {
      bird.update(t, pipeSpawner);
      pipeSpawner.update(t);
      score.update(t, bird, pipeSpawner);
    }
  }

  void onTapDown(TapDownDetails evt) {
    print("GameScreen: " + gs.toString());
    if (GameScreen.PLAYING == gs) {
      bird.onTap(evt);
    } else if (GameScreen.GAME_OVER == gs) {
      go.onTap(evt, callbackSetGameScreenRetry);
    } else if (GameScreen.START == gs) {
      sg.onTap(evt, callbackSetGameScreenStart);
    }
  }

  void callbackSetGameScreenStart(GameScreen gs) {
    print("callback " + gs.toString());
    this.gs = gs;
  }

  void callbackSetGameScreenRetry(GameScreen gs) {
    print("callback " + gs.toString());
    this.gs = gs;
    bird = Bird(this);
    pipeSpawner = PipeSpawner(this);
  }
}
