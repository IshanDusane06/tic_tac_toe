import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/pages/tic_tac_toe_board.dart/view/player_details.dart';
import 'package:tic_tac_toe/pages/tic_tac_toe_board.dart/view/tic_tac_toe_board.dart';

class Routes {
  static final appRoutes = Provider(
    (ref) => GoRouter(
      initialLocation: PlayerDetails.id,
      routes: [
        GoRoute(
          path: PlayerDetails.id,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PlayerDetails(),
          ),
          routes: [
            GoRoute(
              path: TicTacToeBoard.id,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: TicTacToeBoard(),
                );
              },
            ),
          ],
        )
      ],
    ),
  );
}

/// Custom transition page with no transition.
class NoTransitionPage<T> extends CustomTransitionPage<T> {
  /// Constructor for a page with no transition functionality.
  const NoTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  }) : super(
          transitionsBuilder: _transitionsBuilder,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );

  static Widget _transitionsBuilder(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) =>
      child;
}
