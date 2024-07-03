import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_logic.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameLogic(),
      child: MaterialApp(
        home: TicTacToeScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFE6E6E9),
          primaryColor: Color(0xFF253652),
          hintColor: Color(0xFF66666E),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}

class TicTacToeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color(0xFF253652),
      ),
      body: Stack(
        children: [

          Positioned.fill(
            child: Image.network(
              'https://i.pinimg.com/originals/5b/36/24/5b3624a6f7f8b5c79615bc3ad301836d.jpg', // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Board(),
              SizedBox(height: 20),
              ResetButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class Board extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameLogic>(
      builder: (context, game, child) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    game.makeMove(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF9999A1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        game.board[index],
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: game.board[index] == 'X' ? Color(0xFFC2FCF7) : Color(0xFFE6E6E9),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameLogic>(
      builder: (context, game, child) {
        return Column(
          children: [
            if (game.winner.isNotEmpty)
              Text(
                '${game.winner} Wins!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC2FCF7), // Wins message color
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.resetGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF253652), // Button color
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Button text color
                ),
              ),
              child: Text('Reset Game', style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }
}
