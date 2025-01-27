import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/pages/tic_tac_toe_board.dart/controller/tic_tac_toe_board.controller.dart';
import 'package:tic_tac_toe/pages/tic_tac_toe_board.dart/view/tic_tac_toe_board.dart';

class PlayerDetails extends ConsumerStatefulWidget {
  static const String id = '/player-details-page';

  const PlayerDetails({super.key});

  @override
  ConsumerState<PlayerDetails> createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends ConsumerState<PlayerDetails> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _playerOneName = TextEditingController();
  final TextEditingController _playerTwoName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Tic Tac Toe',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF555095),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Player One (X)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF555095),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // style: const TextStyle(color: Colors.white),
                      controller: _playerOneName,
                      decoration: InputDecoration(
                        label: const Text(
                          'Name',
                        ),
                        floatingLabelStyle:
                            const TextStyle(color: Color(0xFF555095)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                            color: Color(0xFF555095),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Player 1 Name';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\s]'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Player Two (O)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF555095),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // style: const TextStyle(color: Colors.white),
                      controller: _playerTwoName,
                      decoration: InputDecoration(
                        label: const Text(
                          'Name',
                        ),
                        floatingLabelStyle:
                            const TextStyle(color: Color(0xFF555095)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                            color: Color(0xFF555095),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Player 2 Name';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\s]'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF555095),
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Border radius
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(ticTacToeControllerProvider.notifier)
                        .enterPlayerDetails(
                          _playerOneName.text,
                          _playerTwoName.text,
                        );
                    context.go('${PlayerDetails.id}/${TicTacToeBoard.id}');
                    _playerOneName.clear();
                    _playerTwoName.clear();
                  }
                },
                child: const Text(
                  'Start Game',
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
    );
  }
}
