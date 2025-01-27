import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/pages/tic_tac_toe_board.dart/controller/tic_tac_toe_board.controller.dart';

class TicTacToeBoard extends ConsumerStatefulWidget {
  static const String id = 'tic-tac-toe-board-page';

  const TicTacToeBoard({super.key});

  @override
  ConsumerState<TicTacToeBoard> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<TicTacToeBoard> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        ref.invalidate(inputProvider);
        ref.invalidate(ticTacToeControllerProvider);
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final board = ref.watch(ticTacToeControllerProvider);
                      return Text(
                        board?.winner != null
                            ? ''
                            : '${board?.currentPlayer == null ? '(X) ${board?.playerOne}' : board?.currentPlayer == 'O' ? '(X) ${board?.playerOne}' : '(O) ${board?.playerTwo}'}\'s Turn',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 375,
                      child: Stack(
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            children: [
                              ...List.generate(
                                9,
                                (index) => GestureDetector(
                                  onTap: () {
                                    if (ref.read(inputProvider(index)) ==
                                        null) {
                                      final currentPlayer = ref
                                          .read(ticTacToeControllerProvider
                                              .notifier)
                                          .getCurrentPlayer();
                                      ref
                                          .read(inputProvider(index).notifier)
                                          .update((state) => currentPlayer);
                                      ref
                                          .read(ticTacToeControllerProvider
                                              .notifier)
                                          .getWinner();
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF555095)
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                    child: Center(
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          final playerInput =
                                              ref.watch(inputProvider(index));
                                          return Text(
                                            playerInput ?? '',
                                            style: const TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final board =
                                  ref.watch(ticTacToeControllerProvider);
                              if (board?.winner != null) {
                                // Apply blur when the game is over
                                return ClipRect(
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.2),
                                      child: Center(
                                        child:
                                            // Text(
                                            //   'Game Over!!!',
                                            //   style: TextStyle(
                                            //     fontSize: 30,
                                            //     fontWeight: FontWeight.w500,
                                            //     color: Color(0xFF555095),
                                            //   ),
                                            // ),
                                            Text(
                                          board?.winner == 'Draw'
                                              ? 'It\'s a Draw'
                                              : '${board?.winner == 'X' ? board?.playerOne : board?.playerTwo} wins!',
                                          style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF555095),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final board = ref.watch(ticTacToeControllerProvider);
                      return Visibility(
                        visible: board?.winner != null,
                        child: const Text(
                          'Game Over!!!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                      // if (board?.winner != null) {
                      //   return Text(
                      //     board?.winner == 'Draw'
                      //         ? 'It\'s a Draw'
                      //         : '${board?.winner == 'X' ? board?.playerOne : board?.playerTwo} wins!',
                      //     style: const TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   );
                      // } else {
                      //   return const SizedBox.shrink();
                      // }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF555095),
                      minimumSize: const Size(double.infinity, 44),
                    ),
                    onPressed: () {
                      ref.invalidate(inputProvider);
                      ref
                          .read(ticTacToeControllerProvider.notifier)
                          .resetToPlayAgain();
                    },
                    child: const Text(
                      'Play again',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF555095),
                      minimumSize: const Size(double.infinity, 44),
                    ),
                    onPressed: () {
                      context.pop();
                      ref.invalidate(inputProvider);
                      ref.invalidate(ticTacToeControllerProvider);
                    },
                    child: const Text(
                      'Reset Game',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
