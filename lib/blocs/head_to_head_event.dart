import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class HeadToHeadEvent extends Equatable {
  const HeadToHeadEvent();
}

class HeadToHeadRequested extends HeadToHeadEvent {
  final String team1id;
  final String team2id;

  const HeadToHeadRequested({
    @required this.team1id,
    @required this.team2id,
  }): assert(team1id!=null),assert(team2id!=null);

  @override
  List<Object> get props => [team1id, team2id];
}
