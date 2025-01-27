// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tic_tac_toe_board.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicTacToeBoardModel _$TicTacToeBoardModelFromJson(Map<String, dynamic> json) =>
    TicTacToeBoardModel(
      currentPlayer: json['currentPlayer'] as String?,
      winner: json['winner'] as String?,
      playerOne: json['playerOne'] as String?,
      playerTwo: json['playerTwo'] as String?,
    );

Map<String, dynamic> _$TicTacToeBoardModelToJson(
        TicTacToeBoardModel instance) =>
    <String, dynamic>{
      'currentPlayer': instance.currentPlayer,
      'winner': instance.winner,
      'playerOne': instance.playerOne,
      'playerTwo': instance.playerTwo,
    };
