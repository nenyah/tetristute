// 格子维度
import 'dart:ui';

int rowLength = 25;
int colLength = 20;
int centerPosition = (colLength / 2).floor();

// 移动方向类型
enum Direction {
  left,
  right,
  down,
}

// 方块类型
enum Tetromino {
  /*
o
o
o o
  
  o
  o
o o

o
o
o
o

o o
o o

  o o
o o

o o
  o o

o
o o
o

 */
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

const Map<Tetromino, Color> tetrominoColor = {
  // 橙色
  Tetromino.L: Color(0xFFFFA500),
  // 蓝色
  Tetromino.J: Color.fromARGB(255, 0, 102, 255),
  // 粉色
  Tetromino.I: Color.fromARGB(255, 242, 0, 255),
  // 黄色
  Tetromino.O: Color(0xFFFFFF00),
  // 绿色
  Tetromino.S: Color(0xFF008000),
  // 红色
  Tetromino.Z: Color(0xFFFF0000),
  // 紫色
  Tetromino.T: Color.fromARGB(255, 144, 0, 255),
};
