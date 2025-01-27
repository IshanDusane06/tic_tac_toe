import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/pages/tic_tac_toe_board.dart/model/tic_tac_toe_board.model.dart';

// final inputProvider = StateProvider<List<String?>>(
//   (ref) => List.generate(
//     9,
//     (index) => null,
//   ),
// );

final inputProvider = StateProvider.family<String?, int>((ref, id) => null);

final ticTacToeControllerProvider =
    StateNotifierProvider<TicTacToeBoardController, TicTacToeBoardModel?>(
        (ref) {
  return TicTacToeBoardController(
    providerRef: ref,
  );
});

class TicTacToeBoardController extends StateNotifier<TicTacToeBoardModel?> {
  TicTacToeBoardController({
    required this.providerRef,
  }) : super(TicTacToeBoardModel(
          currentPlayer: null,
          winner: null,
        ));

  StateNotifierProviderRef providerRef;

  String getCurrentPlayer() {
    if (state?.currentPlayer == null) {
      state = state?.copyWith(currentPlayer: 'X');
      return 'X';
    } else {
      if (state?.currentPlayer == 'X') {
        state = state?.copyWith(currentPlayer: 'O');
        return 'O';
      } else {
        state = state?.copyWith(currentPlayer: 'X');
        return 'X';
      }
    }
  }

  void getWinner() {
    // List<String> board = providerRef.read(inputProvider)
    // for (var row in [0, 1, 2]) {
    //   if (getInputValue(0) != null &&
    //       getInputValue(0) == getInputValue(1) &&
    //       getInputValue(1) == getInputValue(1)) {
    //     state = state?.copyWith(
    //         winner: getInputValue(0)); // Return the winner ('X' or 'O')
    //   }
    // }

    // // Check columns for a winner
    // for (int col = 0; col < 3; col++) {
    //   if (getInputValue(index)[0][col] != null &&
    //       getInputValue(index)[0][col] == getInputValue(index)[1][col] &&
    //       getInputValue(index)[1][col] == getInputValue(index)[2][col]) {
    //     return getInputValue(index)[0][col]; // Return the winner ('X' or 'O')
    //   }
    // }

    const List<List<int>> winningCombinations = [
      [0, 1, 2], // Top row
      [3, 4, 5], // Middle row
      [6, 7, 8], // Bottom row
      [0, 3, 6], // Left column
      [1, 4, 7], // Middle column
      [2, 5, 8], // Right column
      [0, 4, 8], // Top-left to bottom-right diagonal
      [2, 4, 6], // Top-right to bottom-left diagonal
    ];

    for (var combination in winningCombinations) {
      int a = combination[0];
      int b = combination[1];
      int c = combination[2];

      if (getInputValue(a) != '' &&
          getInputValue(a) == getInputValue(b) &&
          getInputValue(b) == getInputValue(c)) {
        state = state?.copyWith(winner: getInputValue(a));
        return;
      }
    }

    bool allFilled = true;
    for (int i = 0; i < 9; i++) {
      if (getInputValue(i) == null) {
        allFilled = false;
        break;
      }
    }
    if (allFilled) {
      state = state?.copyWith(winner: 'Draw');
      return;
    }
  }

  String? getInputValue(int index) {
    return providerRef.read(inputProvider(index));
  }

  void enterPlayerDetails(String playerOne, String playerTwo) {
    state = state?.copyWith(playerOne: playerOne, playerTwo: playerTwo);
    print(state);
  }

  void resetToPlayAgain() {
    state = TicTacToeBoardModel(
      currentPlayer: null,
      winner: null,
      playerOne: state?.playerOne,
      playerTwo: state?.playerTwo,
    );
    print(state);
  }
}
