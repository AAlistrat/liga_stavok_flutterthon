import 'package:liga_stavok_flutterthon/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SportRadarApiClient {
  static const String baseUrl = 'https://api.sportradar.us/soccer';
  static const String accessLevel = 't';
  static const String version = '3';
  static const String leagueGroup = 'intl';
  static const String languageCode = 'en';
  static const String apiKey = 'xpg55ybqvq6rrf68wfmrebtu';
  final http.Client httpClient;

  SportRadarApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<String>> getTeamIds() async {
    final request = '$baseUrl-$accessLevel$version/$leagueGroup/$languageCode/teams/v2_v3_id_mappings.json?api_key=$apiKey';
    final response = await this.httpClient.get(request);
    if (response.statusCode != 200) {
      throw Exception('problems with getting team sr ids');
    }
    List<String> teamIds = [];
    final responseJson = jsonDecode(response.body);
    for (var resp in responseJson['team_mappings']) {
      teamIds.add(resp['v3_id']);
    }
    return teamIds;
  }

  Future<String> getTeamName(String teamId) async {
    final request = '$baseUrl-$accessLevel$version/$leagueGroup/$languageCode/teams/$teamId/profile.json?api_key=$apiKey';
    final response = await this.httpClient.get(request);
    if (response.statusCode != 200) {
      throw Exception('problems with getting team sr ids');
    }
    final responseJson = jsonDecode(response.body);
    return responseJson['team']['name'];
  }

  Future<HeadToHead> getHeadToHead(String langCode, String team1id, String team2id) async {
    final request = '$baseUrl-$accessLevel$version/$leagueGroup/$langCode/teams/$team1id/versus/$team2id/matches.json?api_key=$apiKey';
    final response = await this.httpClient.get(request);
    if (response.statusCode != 200) {
      throw Exception('problems with getting head-to-head');
    }
    final responseJson = jsonDecode(response.body);
    return HeadToHead.fromJson(responseJson);
  }
}