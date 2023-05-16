import 'package:flutter/material.dart';
import 'package:tetristute/values.dart';

import 'board.dart';

class Piece {
  // 方块类型
  Tetromino type;
  Piece({required this.type});
  // 方块其实是一个整形列表
  List<int> position = [];

// 方块颜色
  Color get color {
    return tetrominoColor[type] ?? Colors.white;
  }

  // 初始化方块
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        // 正向整数减去30倒退三轮，让方块一点一点出现
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        // 正向整数减去30倒退三轮，让方块一点一点出现
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        // 正向整数减去10倒退一轮，让方块一点一点出现
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        // 正向整数减去20倒退二轮，让方块一点一点出现
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        // 正向整数减去20倒退二轮，让方块一点一点出现
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        // 正向整数减去20倒退二轮，让方块一点一点出现
        position = [
          -16,
          -15,
          -5,
          -4,
        ];
        break;
      case Tetromino.T:
        // 正向整数减去30倒退三轮，让方块一点一点出现
        position = [
          -26,
          -16,
          -15,
          -6,
        ];
        break;
      default:
    }
  }

  // 移动方块
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          // 当前序号值加上列数移动到下一个位置
          position[i] += colLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  // 旋转方块
  int rotationState = 1;
  void rotatePiece() {
    // 新位置
    List<int> newPosition = [];
    // 基于类型旋转方块
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            /*
                *
                *
                * *
             */
            newPosition = [
              position[1] - colLength,
              position[1],
              position[1] + colLength,
              position[1] + colLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*
              * * *
              *
             */

            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + colLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*
                * *
                  *
                  *
            */

            newPosition = [
              position[1] + colLength,
              position[1],
              position[1] - colLength,
              position[1] - colLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*
                     *
                 * * *
            */

            newPosition = [
              position[1] - colLength - 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
          default:
        }
        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            /*
                   *
                   *
                 * *
             */
            newPosition = [
              position[1] - colLength,
              position[1],
              position[1] + colLength,
              position[1] + colLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*
                *
                * * *
             */

            newPosition = [
              position[1] - colLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*
                * *
                *
                *
            */

            newPosition = [
              position[1] + colLength,
              position[1],
              position[1] - colLength,
              position[1] - colLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*
                * * *
                    *
            */

            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + colLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
          default:
        }
        break;
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            /*
                * * * *
             */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*
                  *
                  *
                  *
                  *
             */

            newPosition = [
              position[1] - colLength,
              position[1],
              position[1] + colLength,
              position[1] + 2 * colLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*
                 * * * *
            */

            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*
                  *
                  *
                  *
                  *
            */

            newPosition = [
              position[1] + colLength,
              position[1],
              position[1] - colLength,
              position[1] - 2 * colLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
          default:
        }
        break;
      case Tetromino.O:
        /*
            * *
            * *
         */
        break;

      case Tetromino.S:
        switch (rotationState) {
          case 0:
            /*
                  * *
                * *
             */
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + colLength - 1,
              position[1] + colLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*
                *
                * *
                  *
             */

            newPosition = [
              position[0] - colLength,
              position[0],
              position[0] + 1,
              position[0] + colLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*
                  * *
                * *
             */

            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + colLength - 1,
              position[1] + colLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*
                *
                * *
                  *
             */

            newPosition = [
              position[0] + colLength,
              position[0],
              position[0] + 1,
              position[0] + colLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
          default:
        }
        break;

      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            /*
                * *
                  * *
             */
            newPosition = [
              position[0] + colLength - 2,
              position[1],
              position[2] + colLength - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*
                    *
                  * *
                  *
             */

            newPosition = [
              position[0] - colLength + 2,
              position[1],
              position[2] - colLength + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*
                * *
                  * *
             */

            newPosition = [
              position[0] + colLength - 2,
              position[1],
              position[2] + colLength - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*
                    *
                  * *
                  *
             */
            newPosition = [
              position[0] - colLength + 2,
              position[1],
              position[2] - colLength + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
          default:
        }
        break;
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            /*
                  *
                  * *
                  *
             */
            newPosition = [
              position[2] - colLength,
              position[2],
              position[2] + 1,
              position[2] + colLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*
                * * *
                  *
             */

            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + colLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*
                  *
                * *
                  *
             */

            newPosition = [
              position[1] - colLength,
              position[1] - 1,
              position[1],
              position[1] + colLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*
                    *
                  * * *
             */
            newPosition = [
              position[2] - colLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
          default:
        }
        break;

      default:
    }
  }

  // 校验方块的所有位置是否有效
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (var position in piecePosition) {
      // 返回 false 如果位置已经被占用
      if (!positionIsValid(position)) {
        return false;
      }
      // 获取当前列序
      int col = position % colLength;
      // 检查是否为首列或尾列
      if (col == 0) {
        firstColOccupied = true;
      }

      if (col == colLength - 1) {
        lastColOccupied = true;
      }
    }
    // 如果方块同时在首列和尾列，说明方块穿过了墙壁
    // 方块 分成两部分，一部分在首列，一部分在尾列
    return !(firstColOccupied && lastColOccupied);
  }

  // 校验新位置是否有效
  bool positionIsValid(int position) {
    int row = (position / colLength).floor();
    int col = position % colLength;

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }
    return true;
  }
}
