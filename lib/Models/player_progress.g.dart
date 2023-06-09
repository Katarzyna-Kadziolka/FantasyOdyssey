// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerProgress _$PlayerProgressFromJson(Map<String, dynamic> json) =>
    PlayerProgress()
      ..progress = (json['progress'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$PhaseEnumMap, k),
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(DateTime.parse(k),
                  (e as List<dynamic>).map((e) => e as int).toList()),
            )),
      );

Map<String, dynamic> _$PlayerProgressToJson(PlayerProgress instance) =>
    <String, dynamic>{
      'progress': instance.progress.map((k, e) => MapEntry(_$PhaseEnumMap[k]!,
          e.map((k, e) => MapEntry(k.toIso8601String(), e)))),
    };

const _$PhaseEnumMap = {
  Phase.bagEndToRivendell: 'bagEndToRivendell',
  Phase.rivendellToLothlorien: 'rivendellToLothlorien',
  Phase.lothlorienToRauros: 'lothlorienToRauros',
  Phase.raurosToMountDoom: 'raurosToMountDoom',
  Phase.minasTirithToIsengard: 'minasTirithToIsengard',
  Phase.isengardToRivendell: 'isengardToRivendell',
  Phase.rivendellToBagEnd: 'rivendellToBagEnd',
  Phase.bagEndToGreyHavens: 'bagEndToGreyHavens',
};
