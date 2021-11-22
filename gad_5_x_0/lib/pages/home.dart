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
  Color? boxColor;
  Color colorPlayerOne = Colors.blue;
  Color colorPlayerTwo = Colors.red;

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
      print('player $playerTurn has won');
      return;
    }
    if (checkDraw()) {
      print('remiza');
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
                      _gameLogic(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: getColorForContainer(index),
                    ),
                    width: 40.0,
                    height: 40.0,
                    child: Center(child: Text('$index')),
                  ),
                ),
              );
            },
          ),
          Visibility(
            visible: isButtonVisible,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _resetGame();
                });
              },
              child: const Text('Play again!'),
            ),
          )
        ],
      ),
    );
  }
}
