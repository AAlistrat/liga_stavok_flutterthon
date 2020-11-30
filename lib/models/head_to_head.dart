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
  final String lastUpdated;
  final List<MatchResult> scoreTable;
  const HeadToHead({this.lastUpdated, this.scoreTable});
  @override
  List<Object> get props => [scoreTable];

  static HeadToHead fromJson(dynamic json) {
    final meetingsResults = json['last_meetings']['results'];
    List<MatchResult> results = [];
    for (int i=0; i < meetingsResults.length; i++) {
      results.add(MatchResult(
        seasonName: meetingsResults[i]['sport_event']['season']['name'],
        date: meetingsResults[i]['sport_event']['scheduled'].substring(0,10),
        homeTeam: meetingsResults[i]['sport_event']['competitors'][0]['qualifier'] == 'home'
             ? meetingsResults[i]['sport_event']['competitors'][0]['name']
             : meetingsResults[i]['sport_event']['competitors'][1]['name'],
        homeScore: meetingsResults[i]['sport_event_status']['home_score'].toString(),
        awayScore: meetingsResults[i]['sport_event_status']['away_score'].toString(),
        awayTeam: meetingsResults[i]['sport_event']['competitors'][0]['qualifier'] == 'away'
             ? meetingsResults[i]['sport_event']['competitors'][0]['name']
             : meetingsResults[i]['sport_event']['competitors'][1]['name'],
      ));
      print(results[i].seasonName);
    }
    return HeadToHead(
      lastUpdated: json['generated_at'].substring(0,10),
      scoreTable: results,
    );
  }
}