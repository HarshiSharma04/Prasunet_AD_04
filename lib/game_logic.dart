import 'package:flutter/material.dart';

class GameLogic with ChangeNotifier {
  late List<String> _board;
  late String _currentPlayer;
  late String _winner;

  GameLogic() {
    resetGame();
  }

  List<String> get board => _board;
  String get currentPlayer => _currentPlayer;
  String get winner => _winner;

  void resetGame() {
    _board = List.generate(9, (index) => '');
    _currentPlayer = 'X';
    _winner = '';
    notifyListeners();
  }

  void makeMove(int index) {
    if (_board[index] == '' && _winner == '') {
      _board[index] = _currentPlayer;
      if (checkWinner(_currentPlayer)) {
        _winner = _currentPlayer;
      } else {
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      }
      notifyListeners();
    }
  }

  bool checkWinner(String player) {
    const List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ];

    for (var pattern in winPatterns) {
      if (_board[pattern[0]] == player &&
          _board[pattern[1]] == player &&
          _board[pattern[2]] == player) {
        return true;
      }
    }
    return false;
  }
}
