import 'dart:ui';

import 'package:flappybird/game.dart';
import 'package:flappybird/pipe_spawner.dart';

import 'bird.dart';

class Score {
  Paragraph paragraph;
  ParagraphBuilder paragraphBuilder;
  final ParagraphStyle paragraphStyle =
      ParagraphStyle(textAlign: TextAlign.center, maxLines: 1);
  final TextStyle textStyle = TextStyle(color: Color(0xFFFFFFFF), fontSize: 75);
  Offset offset;
  int score = 0;
  Bird bird;
  BirdGame birdGame;

  Score(BirdGame game) {
    birdGame = game;
  }

  void render(Canvas canvas) {
    paragraphBuilder = ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(score.toString());
    paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: 100));
    offset = Offset(birdGame.screenSize.width / 2 - paragraph.width / 2,
        birdGame.tileSize * 2);
    canvas.drawParagraph(paragraph, offset);
  }

  void update(double t, Bird bird, PipeSpawner pipeSpawner) {
    score = 0;
    pipeSpawner.pipes.forEach((pipe) {
      if (pipe.pipeRectUp.right < bird.birdRect.left) score++;
    });
  }
}
