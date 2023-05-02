import 'package:fantasy_odyssey/Models/phase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'progress.g.dart';

@JsonSerializable()
class Progress {
  final Map<Phase, Map<DateTime, List<int>>> progress;

  Progress(this.progress);

  factory Progress.fromJson(Map<String, dynamic> json) => _$ProgressFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressToJson(this);
}