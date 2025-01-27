import 'package:json_annotation/json_annotation.dart';

part 'tic_tac_toe_board.model.g.dart';

@JsonSerializable()
class TicTacToeBoardModel {
  TicTacToeBoardModel({
    this.currentPlayer,
    this.winner,
    this.playerOne,
    this.playerTwo,
  });
  factory TicTacToeBoardModel.fromJson(Map<String, dynamic> json) =>
      _$TicTacToeBoardModelFromJson(json);

  final String? currentPlayer;
  final String? winner;
  final String? playerOne;
  final String? playerTwo;

  Map<String, dynamic> toJson() => _$TicTacToeBoardModelToJson(this);

  TicTacToeBoardModel copyWith({
    String? currentPlayer,
    String? winner,
    String? playerOne,
    String? playerTwo,
  }) {
    return TicTacToeBoardModel(
      currentPlayer: currentPlayer ?? this.currentPlayer,
      winner: winner ?? this.winner,
      playerOne: playerOne ?? this.playerOne,
      playerTwo: playerTwo ?? this.playerTwo,
    );
  }
}
