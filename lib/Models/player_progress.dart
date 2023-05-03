import 'package:fantasy_odyssey/Models/phase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_progress.g.dart';

@JsonSerializable()
class PlayerProgress {
  final Map<Phase, Map<DateTime, List<int>>> progress;

  PlayerProgress(this.progress);

  factory PlayerProgress.fromJson(Map<String, dynamic> json) => _$PlayerProgressFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerProgressToJson(this);
}