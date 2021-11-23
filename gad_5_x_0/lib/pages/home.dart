import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _ticTacToe = <String>[];
  final List<List<int>> _indexesToCheck = <List<int>>[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  String playerTurn = 'x';
  bool isButtonVisible = false;
  bool isGameOver = false;
  int scorePlayerOne = 0;
  int scorePlayerTwo = 0;

  @override
  void initState() {
    super.initState();
    _initGame();
    _printGame();
  }

  void _initGame() {
    for (int i = 0; i < 9; i++) {
      _ticTacToe.add(' ');
    }
  }

  void _resetGame() {
    for (int i = 0; i < _ticTacToe.length; i++) {
      _ticTacToe[i] = ' ';
    }

    isGameOver = false;
    isButtonVisible = false;
    playerTurn = 'x';
  }

  void _printGame() {
    String game = '';
    for (int i = 0; i < 9; i++) {
      if (i % 3 == 0) {
        game += '\n';
      }
      game += _ticTacToe[i];
    }
    print(game);
    print('----');
  }

  Color? getColorForContainer(int index) {
    if (isGameOver) {
      if (playerTurn == 'x' && _ticTacToe[index] == '0') {
          return Colors.grey;
      }

      if (playerTurn == '0' && _ticTacToe[index] == 'x') {
        return Colors.grey;
      }
    }

    if (_ticTacToe[index] == 'x') {
      return Colors.blue;
    }
    if (_ticTacToe[index] == '0') {
      return Colors.red;
    }

    return null;
  }

  bool checkWin(String turn) {
    bool hasWon;

    for (List<int> indexes in _indexesToCheck) {
      hasWon = true;
      for (int index in indexes) {
        if (_ticTacToe[index] != turn) {
          hasWon = false;
          break;
        }
      }

      if (hasWon) {
        return true;
      }
    }

    return false;
  }

  bool checkDraw() {
    return !_ticTacToe.contains(' ');
  }

  void _gameLogic(int index) {
    _ticTacToe[index] = playerTurn;

    if (checkWin(playerTurn)) {
      if (playerTurn == 'x') {
        scorePlayerOne++;
      } else {
        scorePlayerTwo++;
      }

      isGameOver = true;
      isButtonVisible = true;
      return;
    }
    if (checkDraw()) {
      isGameOver == true;
      isButtonVisible = true;
      return;
    }

    playerTurn = playerTurn == 'x' ? '0' : 'x';

    _printGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'tic-tac-toe',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Text>[
                Text('Player one score: $scorePlayerOne'),
                Text('Player two score: $scorePlayerTwo'),
              ],
            ),
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 9,
            padding: const EdgeInsets.all(4.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                constraints: const BoxConstraints.expand(),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (!isGameOver && _ticTacToe[index] == ' ') {
                        _gameLogic(index);
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: getColorForContainer(index),
                    ),
                    width: 40.0,
                    height: 40.0,
                  ),
                ),
              );
            },
          ),
          Visibility(
            visible: isButtonVisible,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _resetGame();
                    });
                  },
                  child: const Text('Play again!'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      scorePlayerOne = 0;
                      scorePlayerTwo = 0;
                    });
                  },
                  child: const Text('ResetScore'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
