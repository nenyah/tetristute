import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetristute/piece.dart';
import 'package:tetristute/pixel.dart';
import 'package:tetristute/values.dart';

// 创建 game board
List<List<Tetromino?>> gameBoard = List.generate(
  rowLength,
  (i) => List.generate(
    colLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // 当前方块
  late Piece currentPiece;
  // 当前分数
  int currentScore = 0;
  // 游戏结束状态
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    //开始游戏
    startGame();
  }

  void startGame() {
    createNewPiece();

    // 刷新帧率
    Duration frameRate = const Duration(milliseconds: 600);
    gameLoop(frameRate);
  }

  // 游戏刷新
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // 检查是否需要清除行
        clearLines();
        // 检查是否触底
        checkLanding();
        if (gameOver == true) {
          timer.cancel();
          showGameOverDialog();
        }
        // 移动当前方块向下
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  // 游戏结束信息
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('你的分数是：$currentScore'),
        actions: [
          TextButton(
              onPressed: () {
                resetGame();
                Navigator.pop(context);
              },
              child: const Text('再来一次')),
        ],
      ),
    );
  }

  void resetGame() {
    // 创建新的游戏区域
    gameBoard = List.generate(
      rowLength,
      (i) => List.generate(
        colLength,
        (j) => null,
      ),
    );
    // 重置游戏状态和分数
    gameOver = false;
    currentScore = 0;
    // 创建新的方块并开始游戏
    createNewPiece();
    startGame();
  }

  // 检测碰撞
  // 返回 true --> 有碰撞
  // 返回 false --> 无碰撞
  bool checkCollision(Direction direction) {
    // 循环当前方块的每个位置
    for (var i = 0; i < currentPiece.position.length; i++) {
      // 计算当前位置的行列数
      int row = (currentPiece.position[i] / colLength).floor();
      int col = currentPiece.position[i] % colLength;

      // 调整行列数
      switch (direction) {
        case Direction.left:
          col -= 1;
          break;
        case Direction.right:
          col += 1;
          break;
        case Direction.down:
          row += 1;
          break;
        default:
      }
      // 检查方块是否出界
      if (row >= rowLength || col < 0 || col >= colLength) {
        return true;
      }
      // 检查当前位置是否被其他方块占用
      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }

    return false;
  }

  void checkLanding() {
    // 如果向下被占用
    if (checkCollision(Direction.down)) {
      // 在 gameboard 上标明已经占用
      for (var i = 0; i < currentPiece.position.length; i++) {
        // 计算当前位置的行列数
        int row = (currentPiece.position[i] / colLength).floor();
        int col = currentPiece.position[i] % colLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      // 触底就创建新的方块
      createNewPiece();
    }
  }

  void createNewPiece() {
    // 创建一个随机类型方块
    Random rand = Random();
    // 创建一个方块类型

    var randomType = Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  // 向左移动
  void moveLeft() {
    if (checkCollision(Direction.left)) {
      return;
    }
    setState(() {
      currentPiece.movePiece(Direction.left);
    });
  }

  // 旋转
  void rotate() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // 向右移动
  void moveRight() {
    if (checkCollision(Direction.right)) {
      return;
    }
    setState(() {
      currentPiece.movePiece(Direction.right);
    });
  }

  // 清除行
  void clearLines() {
    // 1. 从底部循环到顶部
    for (var row = rowLength - 1; row >= 0; row--) {
      // 2. 检查列是否满了
      bool rowIsFull = true;
      for (var col = 0; col < colLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      // 3. 如果满了，从当前满的行，循环复制上一行内容
      if (rowIsFull) {
        for (var r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        // 首行清空
        gameBoard[0] = List.generate(row, (index) => null);
        // 增加分数
        currentScore++;
      }
    }
  }

  // 游戏结束判断
  bool isGameOver() {
    // 检查是否有任意列的首行被填充
    for (var col = 0; col < colLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            // 游戏
            Expanded(
              child: GridView.builder(
                  itemCount: rowLength * colLength,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: colLength),
                  itemBuilder: (context, index) {
                    // 计算当前位置的行列数
                    int row = (index / colLength).floor();
                    int col = index % colLength;
                    // 当前 方块
                    if (currentPiece.position.contains(index)) {
                      return Pixel(color: currentPiece.color);
                    }
                    // 触底方块
                    else if (gameBoard[row][col] != null) {
                      final Tetromino? tetrominoType = gameBoard[row][col];
                      return Pixel(color: tetrominoColor[tetrominoType]);
                    }
                    // 空白格子
                    else {
                      return Pixel(color: Colors.grey[900]);
                    }
                  }),
            ),

            // 分数
            Text(
              '当前分数：$currentScore',
              style: const TextStyle(color: Colors.white),
            ),
            // 游戏控制
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 左
                  IconButton(
                      onPressed: moveLeft,
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_back)),

                  // 旋转
                  IconButton(
                      onPressed: rotate,
                      color: Colors.white,
                      icon: const Icon(Icons.rotate_right)),
                  // 右
                  IconButton(
                      onPressed: moveRight,
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_forward)),
                ],
              ),
            )
          ],
        ));
  }
}
