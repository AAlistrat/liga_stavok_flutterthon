import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class MatchResult {
  String seasonName;
  String date;
  String homeTeam;
  String homeScore;
  String awayTeam;
  String awayScore;
  MatchResult({
   @required this.seasonName,
   @required this.date,
   @required this.homeTeam,
   @required this.homeScore,
   @required this.awayTeam,
   @required this.awayScore,
});
}

class HeadToHead extends Equatable {
  final DateTime lastUpdated;
  final List<MatchResult> scoreTable;
  const HeadToHead({this.lastUpdated, this.scoreTable});
  @override
  List<Object> get props => [scoreTable];

  static HeadToHead fromJson(dynamic json) {
    final meetingsResults = json['last_meetings']['results'];
    List<MatchResult> results = [];
    for (var result in meetingsResults) {
      results.add(MatchResult(
        seasonName: result['sport_event']['season']['name'],
        date: result['sport_event']['scheduled'],
        homeTeam: result['sport_event']['competitors'][0]['qualifier'] == 'home'
            ? result['sport_event']['competitors'][0]['name']
            : result['sport_event']['competitors'][1]['name'],
        homeScore: result['sport_event_status']['home_score'],
        awayScore: result['sport_event_status']['away_score'],
        awayTeam: result['sport_event']['competitors'][0]['qualifier'] == 'away'
            ? result['sport_event']['competitors'][0]['name']
            : result['sport_event']['competitors'][1]['name'],
      ));
    }
    return HeadToHead(
      lastUpdated: DateTime.now(),
      scoreTable: results,
    );
  }
}